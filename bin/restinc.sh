#!/usr/bin/env bash
#
## echo "hi"
## base=$(dirname $0)
## echo $base
## echo $MMIX_SRC
## echo $MMIX_INC
## echo $PWD
#
fn=$(basename $PWD)
src=$fn.mms
incsave=$fn.incsave
cp $incsave $src
