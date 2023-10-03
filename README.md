Yash shell, built with Zig

Yash: https://github.com/magicant/yash

Version: https://github.com/magicant/yash/releases/download/2.55/yash-2.55.tar.gz

`zig build && ./zig-out/bin/yash`

To update Yash version in this repo, run `update_yash.sh`.

All optional features enabled except for:
* lineedit and history (which require ncurses)
* nls

Note that the yash code here is redistributed unmodified and is licensed under
GPLv2. See yash/COPYING.

Todo:
* Improve cross-compilation. `config.h` and `signum.h` change per architecture.
  Currently I've just put copies of those files in `arch/` for MacOS and Linux.
* Enable lineedit and history
* Enable nls
