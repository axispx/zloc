const std = @import("std");
const languages = @import("languages.zig");
const lexer = @import("lexer.zig");

pub const Counts = lexer.Counts;
pub const Language = languages.Language;

pub const LanguageSummary = struct {
    language: Language,
    files: u64 = 0,
    counts: Counts = .{},
};

pub const SummarySet = [languages.supported_languages.len]LanguageSummary;

const ColumnGap = 4;
const LanguageColumnWidth = 24;

const ColumnWidths = struct {
    language: usize = LanguageColumnWidth,
    files: usize = "Files".len,
    blank: usize = "Blank".len,
    comment: usize = "Comment".len,
    code: usize = "Code".len,
};

pub fn initSummaries() SummarySet {
    var summaries: SummarySet = undefined;

    for (languages.supported_languages, 0..) |language, index| {
        summaries[index] = .{
            .language = language,
        };
    }

    return summaries;
}

pub fn addFile(summaries: *SummarySet, language: Language, counts: Counts) void {
    const summary = summaryFor(summaries, language);
    summary.files += 1;
    addCounts(&summary.counts, counts);
}

fn summaryFor(summaries: *SummarySet, language: Language) *LanguageSummary {
    for (summaries) |*summary| {
        if (summary.language == language) {
            return summary;
        }
    }

    unreachable;
}

fn addCounts(total: *Counts, counts: Counts) void {
    total.blank += counts.blank;
    total.comment += counts.comment;
    total.code += counts.code;
}

pub fn printSummaryTable(summaries: []const LanguageSummary) void {
    var total = LanguageSummary{
        .language = .c,
    };
    var sorted: [languages.supported_languages.len]LanguageSummary = undefined;
    var sorted_count: usize = 0;

    for (summaries) |summary| {
        if (summary.files == 0) {
            continue;
        }

        total.files += summary.files;
        addCounts(&total.counts, summary.counts);
        sorted[sorted_count] = summary;
        sorted_count += 1;
    }

    const widths = calculateWidths(summaries, total);
    sortByCode(sorted[0..sorted_count]);

    printHeader(widths);

    for (sorted[0..sorted_count]) |summary| {
        printRow(widths, languages.name(summary.language), summary.files, summary.counts);
    }

    printSeparator(widths);
    printRow(widths, "Total", total.files, total.counts);
    printSeparator(widths);
}

fn sortByCode(summaries: []LanguageSummary) void {
    std.mem.sort(LanguageSummary, summaries, {}, compareByCodeDesc);
}

fn compareByCodeDesc(_: void, lhs: LanguageSummary, rhs: LanguageSummary) bool {
    if (lhs.counts.code != rhs.counts.code) {
        return lhs.counts.code > rhs.counts.code;
    }

    return std.mem.lessThan(u8, languages.name(lhs.language), languages.name(rhs.language));
}

fn calculateWidths(summaries: []const LanguageSummary, total: LanguageSummary) ColumnWidths {
    var widths = ColumnWidths{};

    for (summaries) |summary| {
        if (summary.files == 0) {
            continue;
        }

        includeLanguage(&widths, languages.name(summary.language));
        includeCounts(&widths, summary.files, summary.counts);
    }

    includeLanguage(&widths, "Total");
    includeCounts(&widths, total.files, total.counts);

    return widths;
}

fn printHeader(widths: ColumnWidths) void {
    printSeparator(widths);
    printLeft("Language", widths.language);
    printGap();
    printRight("Files", widths.files);
    printGap();
    printRight("Blank", widths.blank);
    printGap();
    printRight("Comment", widths.comment);
    printGap();
    printRight("Code", widths.code);
    std.debug.print("\n", .{});
    printSeparator(widths);
}

fn printSeparator(widths: ColumnWidths) void {
    const width = widths.language + widths.files + widths.blank + widths.comment + widths.code +
        (ColumnGap * 4);

    var i: usize = 0;
    while (i < width) : (i += 1) {
        std.debug.print("-", .{});
    }
    std.debug.print("\n", .{});
}

fn printRow(widths: ColumnWidths, language: []const u8, files: u64, counts: Counts) void {
    printLeft(language, widths.language);
    printGap();
    printRightInt(files, widths.files);
    printGap();
    printRightInt(counts.blank, widths.blank);
    printGap();
    printRightInt(counts.comment, widths.comment);
    printGap();
    printRightInt(counts.code, widths.code);
    std.debug.print("\n", .{});
}

fn includeLanguage(widths: *ColumnWidths, language: []const u8) void {
    widths.language = @max(widths.language, language.len);
}

fn includeCounts(widths: *ColumnWidths, files: u64, counts: Counts) void {
    widths.files = @max(widths.files, commaWidth(files));
    widths.blank = @max(widths.blank, commaWidth(counts.blank));
    widths.comment = @max(widths.comment, commaWidth(counts.comment));
    widths.code = @max(widths.code, commaWidth(counts.code));
}

fn decimalWidth(value: u64) usize {
    var width: usize = 1;
    var remaining = value;

    while (remaining >= 10) {
        remaining /= 10;
        width += 1;
    }

    return width;
}

fn commaWidth(value: u64) usize {
    const digits = decimalWidth(value);
    return digits + ((digits - 1) / 3);
}

fn printLeft(text: []const u8, width: usize) void {
    std.debug.print("{s}", .{text});
    printSpaces(width -| text.len);
}

fn printRight(text: []const u8, width: usize) void {
    printSpaces(width -| text.len);
    std.debug.print("{s}", .{text});
}

fn printRightInt(value: u64, width: usize) void {
    var buffer: [32]u8 = undefined;
    const text = formatCommaInt(&buffer, value);
    printRight(text, width);
}

fn formatCommaInt(buffer: []u8, value: u64) []const u8 {
    var digits_buffer: [20]u8 = undefined;
    const digits = std.fmt.bufPrint(&digits_buffer, "{}", .{value}) catch unreachable;
    const comma_count = (digits.len - 1) / 3;
    const output_len = digits.len + comma_count;

    var digit_index = digits.len;
    var output_index = output_len;
    var group_digits: usize = 0;

    while (digit_index > 0) {
        if (group_digits == 3) {
            output_index -= 1;
            buffer[output_index] = ',';
            group_digits = 0;
        }

        digit_index -= 1;
        output_index -= 1;
        buffer[output_index] = digits[digit_index];
        group_digits += 1;
    }

    return buffer[0..output_len];
}

fn printGap() void {
    printSpaces(ColumnGap);
}

fn printSpaces(count: usize) void {
    var i: usize = 0;
    while (i < count) : (i += 1) {
        std.debug.print(" ", .{});
    }
}

test "formats integers with commas" {
    var buffer: [32]u8 = undefined;

    try std.testing.expectEqualStrings("0", formatCommaInt(&buffer, 0));
    try std.testing.expectEqualStrings("999", formatCommaInt(&buffer, 999));
    try std.testing.expectEqualStrings("1,000", formatCommaInt(&buffer, 1000));
    try std.testing.expectEqualStrings("1,234,567", formatCommaInt(&buffer, 1234567));
}

test "sorts summaries by code descending" {
    var summaries = [_]LanguageSummary{
        .{ .language = .zig, .files = 1, .counts = .{ .code = 4 } },
        .{ .language = .c, .files = 1, .counts = .{ .code = 9 } },
        .{ .language = .go, .files = 1, .counts = .{ .code = 6 } },
    };

    sortByCode(&summaries);

    try std.testing.expectEqual(Language.c, summaries[0].language);
    try std.testing.expectEqual(Language.go, summaries[1].language);
    try std.testing.expectEqual(Language.zig, summaries[2].language);
}
