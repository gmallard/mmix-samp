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
fnw=$fn.work
incsave=$fn.incsave
#
rm $obj $lst $fnw $incsave 2>/dev/null
