const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    var optimize = b.standardOptimizeOption(.{});
    const strip = b.option(bool, "strip", "Omit debug information") orelse true;

    const arch_path = blk: {
        if (target.os_tag) |os| {
            if (os.isDarwin()) break :blk "macos";
        } else {
            if (@import("builtin").os.tag.isDarwin()) break :blk "macos";
        }
        break :blk "linux";
    };

    const exe = b.addExecutable(.{
        .name = "yash",
        .target = target,
        .optimize = optimize,
    });
    exe.strip = strip;
    exe.addCSourceFiles(&srcs, &[_][]const u8{});
    exe.addIncludePath(.{ .path = "yash" });
    exe.addIncludePath(.{ .path = "arch/" ++ arch_path });
    exe.addIncludePath(.{ .path = "yash/builtins" });
    exe.linkLibC();

    // TODO: enable lineedit
    // const lineedit = b.option(bool, "lineedit", "Include lineedit and history") orelse false;
    // if (lineedit) {
    //   exe.addCSourceFiles(&lineedit_srcs, &[_][]const u8{});
    //   exe.addIncludePath(.{ .path = "yash/lineedit" });
    //   exe.linkSystemLibrary("ncurses");
    // }

    b.installArtifact(exe);

    const runstep = b.step("run", "Run yash");
    const run = b.addRunArtifact(exe);
    if (b.args) |args| run.addArgs(args);
    runstep.dependOn(b.getInstallStep());
    runstep.dependOn(&run.step);
}

const srcs = [_][]const u8{
    "yash/alias.c",
    "yash/arith.c",
    "yash/builtin.c",
    "yash/exec.c",
    "yash/expand.c",
    "yash/hashtable.c",
    "yash/history.c",
    "yash/input.c",
    "yash/job.c",
    "yash/mail.c",
    "yash/option.c",
    "yash/parser.c",
    "yash/path.c",
    "yash/plist.c",
    "yash/redir.c",
    "yash/sig.c",
    "yash/strbuf.c",
    "yash/util.c",
    "yash/variable.c",
    "yash/xfnmatch.c",
    "yash/xgetopt.c",
    "yash/yash.c",
    "yash/builtins/printf.c",
    "yash/builtins/test.c",
    "yash/builtins/ulimit.c",
};

const lineedit_srcs = [_][]const u8{
    "yash/lineedit/complete.c",
    "yash/lineedit/compparse.c",
    "yash/lineedit/display.c",
    "yash/lineedit/editing.c",
    "yash/lineedit/keymap.c",
    "yash/lineedit/lineedit.c",
    "yash/lineedit/terminfo.c",
    "yash/lineedit/trie.c",
};

// TODO: Add options for config.h values
// These are all the options that can go into config.h
// They are specified in configure with defconfigh. Most are set by
// auto-detection.
//
// cat configure | grep defconfigh | tail -n +2 | sed -e 's/^[[:space:]]*//' | sed 's/^defconfigh \(.*\)/\1/'
//
// "_DARWIN_C_SOURCE"
// "__EXTENSIONS__"
// "NDEBUG"
// "_POSIX_C_SOURCE" "${posix}L"
// "_XOPEN_SOURCE" "${xopen}"
// "YASH_ENABLE_SOCKET"
// "HAVE_NGETTEXT"
// "HAVE_GETTEXT"
// "HAVE_${i#*:}"
// "HAVE_${i#*:}"
// "YASH_ENABLE_LINEEDIT"
// "HAVE_PROC_SELF_EXE"
// "HAVE_PROC_CURPROC_FILE"
// "HAVE_PROC_OBJECT_AOUT"
// "HAVE_STRNLEN"
// "HAVE_STRDUP"
// "HAVE_WCSNLEN"
// "HAVE_WCSDUP"
// "HAVE_WCSCASECMP"
// "HAVE_WCSNRTOMBS"
// "HAVE_WCSTOLD"
// "HAVE_WCWIDTH"
// "HAVE_S_ISVTX"
// "UNSETENV_RETURNS_INT"
// "HAVE_ST_ATIM"
// "HAVE_ST_ATIMESPEC"
// "HAVE_ST_ATIMENSEC"
// "HAVE___ST_ATIMENSEC"
// "HAVE_ST_MTIM"
// "HAVE_ST_MTIMESPEC"
// "HAVE_ST_MTIMENSEC"
// "HAVE___ST_MTIMENSEC"
// "HAVE_WCONTINUED"
// "HAVE_FACCESSAT"
// "HAVE_EACCESS"
// "HAVE_STRSIGNAL"
// "HAVE_GETPWENT"
// "HAVE_PW_GECOS"
// "HAVE_GETGRENT"
// "HAVE_GETHOSTENT"
// "HAVE_PATHS_H"
// "GETCWD_AUTO_MALLOC"
// "HAVE_TIOCGWINSZ"
// "WIO_BROKEN"
// "FGETWS_BROKEN"
// "YASH_ENABLE_ARRAY"
// "YASH_ENABLE_DOUBLE_BRACKET"
// "YASH_ENABLE_DIRSTACK"
// "YASH_ENABLE_HELP"
// "YASH_ENABLE_HISTORY"
// "YASH_ENABLE_PRINTF"
// "YASH_ENABLE_TEST"
// "YASH_ENABLE_ULIMIT"
// "HAVE_RLIM_SAVED_${i}"
// "HAVE_RLIMIT_${i}"
