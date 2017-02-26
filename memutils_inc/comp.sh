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
obj=$fn.mmo
lst=$fn.lst
incf=$fn.includes
#
cp $src $src.save
for f in $(cat $incf)
do
    cat $MMIX_INC/$f >> $src
done
#
mmixal -l $lst -o $obj $src
cp $src.save $src

