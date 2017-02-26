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
obj=$fn.mmo
lst=$fn.lst
incs=$fn.incsave
#
rm $obj $lst $incs 2>/dev/null

