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

const ColumnGap = 2;

const ColumnWidths = struct {
    language: usize = "Language".len,
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

    for (summaries) |summary| {
        if (summary.files == 0) {
            continue;
        }

        total.files += summary.files;
        addCounts(&total.counts, summary.counts);
    }

    const widths = calculateWidths(summaries, total);

    printHeader(widths);

    for (summaries) |summary| {
        if (summary.files == 0) {
            continue;
        }

        printRow(widths, languages.name(summary.language), summary.files, summary.counts);
    }

    printSeparator(widths);
    printRow(widths, "Total", total.files, total.counts);
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
    widths.files = @max(widths.files, decimalWidth(files));
    widths.blank = @max(widths.blank, decimalWidth(counts.blank));
    widths.comment = @max(widths.comment, decimalWidth(counts.comment));
    widths.code = @max(widths.code, decimalWidth(counts.code));
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
    const text = std.fmt.bufPrint(&buffer, "{}", .{value}) catch unreachable;
    printRight(text, width);
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
