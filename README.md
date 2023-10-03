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
* Improve cross-compilation by:
  * Allowing specifying all `config.h` members
  * Porting the auto-detection in `configure` to `build.zig`
* Enable lineedit and history
* Enable nls
