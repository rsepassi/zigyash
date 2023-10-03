#!/bin/bash

set -e

VERSION=${1:-2.55}
DST=$PWD/yash

echo "Updating yash to version $VERSION"

TMP=$(mktemp -d)
pushd $TMP
echo "Temporary working directory $TMP"


CACHE_DIR="$HOME/.cache/zigyash"
DL="$CACHE_DIR/yash-$VERSION.tar.gz"
URL="https://github.com/magicant/yash/releases/download/$VERSION/yash-$VERSION.tar.gz"
if [[ ! -f $DL ]]
then
  mkdir -p $CACHE_DIR
  pushd $CACHE_DIR
  wget $URL
  popd
fi
tar xf $DL
cd yash-$VERSION


rm -rf $DST
mkdir -p $DST

CC="zig cc" \
./configure \
  --enable-array \
  --enable-dirstack \
  --enable-double-bracket \
  --enable-help \
  --enable-printf \
  --enable-test \
  --enable-ulimit \
  --enable-socket \
  --enable-history \
  --enable-lineedit=no \
  --enable-nls=no
make -j8 yash


cp COPYING $DST

cp \
      alias.c \
      arith.c \
      builtin.c \
      exec.c \
      expand.c \
      hashtable.c \
      history.c \
      input.c \
      job.c \
      mail.c \
      option.c \
      parser.c \
      path.c \
      plist.c \
      redir.c \
      sig.c \
      strbuf.c \
      util.c \
      variable.c \
      xfnmatch.c \
      xgetopt.c \
      yash.c \
      *.h \
  $DST

mkdir -p $DST/builtins
cp \
      builtins/printf.c \
      builtins/test.c \
      builtins/ulimit.c \
      builtins/*.h \
  $DST/builtins/

mkdir -p $DST/lineedit
cp \
      lineedit/complete.c \
      lineedit/compparse.c \
      lineedit/display.c \
      lineedit/editing.c \
      lineedit/keymap.c \
      lineedit/lineedit.c \
      lineedit/terminfo.c \
      lineedit/trie.c \
      lineedit/commands.in \
      lineedit/*.h \
  $DST/lineedit/

popd

echo "yash sources updated"
