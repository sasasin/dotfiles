This package provides two minor modes which automatically recompile
Emacs Lisp source files.  Together these modes guarantee that Emacs
never loads outdated byte code files.

`auto-compile-on-save-mode' recompiles source files when they are
being saved and `auto-compile-on-load-mode' does so before they are
being loaded.  Both modes only _recompile_ a source file when the
respective byte code file exists and is outdated.  Otherwise (when
the byte code file doesn't exist or is up-to-date) these modes do
_not_ compile the source file.

To permanently or temporarily toggle automatic compilation of some
source file use the command `toggle-auto-compile'.  Since the modes
only ever _update_ byte code files, toggling automatic compilation
is done simply by either creating the byte code file or removing
it.  `toggle-auto-compile' can also toggle automatic compilation of
multiple files at once; see it's doc-string for more information.

Even when using `auto-compile-on-save-mode' it can happen that some
source file is newer than the respective byte code file.  This can
for example happen when performing version control operations and
is a problem because Emacs always loads the byte code file even
when the respective source file has been modified since the former
was created.

To prevent outdated byte code files from being loaded
`auto-compile-on-load-mode' advises `require' and `load' to first
recompile a source file if it is newer than the respective byte
code file.

Enabling `auto-compile-on-load-mode' as early as possible reduces
the risk of loading an outdated byte code file.  It is best if you
enable both modes together at the beginning of your init file, even
before loading your package manager and having it initialize the
`load-path'.

    ;; -*- no-byte-compile: t -*-
    (add-to-list 'load-path "/path/to/auto-compile")
    (require 'auto-compile)
    (auto-compile-on-load-mode 1)
    (auto-compile-on-save-mode 1)

Automatically compilation of Emacs Lisp source files is useful for
at least the following reasons:

◆ Emacs prefers the byte code file over the source file even if the
  former is outdated.  If you have to do the compilation manually
  you will at least occasionally forget to do so and end up with an
  old version of your code being loaded.

◆ There are many otherwise fine libraries to be found on the
  Internet which when compiled will confront the user with a wall
  of compile warnings and an occasional error.  If authors are
  informed about these (often trivial) problems after each save
  they will likely fix them quite quickly.  That or they have a
  high noise tolerance.

◆ It's often easier and less annoying to fix errors and warnings as
  they are introduced than to do a "let's compile today's work and
  see how it goes".

This package is designed to stay out of your way as much as it can
while still motivating you to get things fixed.  That might be
annoying initially but less so once existing problems have been
fixed.  By default Auto-Compile won't let you quit Emacs on the
first attempt without fixing fatal errors in visited source files
first.  To disable this set `auto-compile-mark-failed-modified' to
nil.

Also note that just because no warnings and/or errors are reported
when a source file is compiled by the modes defined here this does
not necessarily mean that users of your libraries won't see any.  A
likely cause for this would be that you forgot to require a feature
which is loaded on your system but not necessarily on the users'
systems.  So you should still manually compile your packages before
release:

    emacs -batch -Q -L . -L ../dependency/ -f batch-byte-compile *.el
