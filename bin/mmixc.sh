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
incdata=$fn.incdata
incsave=$fn.incsave
fnw=$fn.work
#
cp $src $incsave
cp $MMIX_INC/prefix.mms $fnw
if [ -e "$incdata" ]
then
    for f in $(cat $incdata)
    do
        cat $MMIX_INCDATA/$f >> $fnw
    done
fi
#
cat $src >> $fnw
#
if [ -e "$incf" ]
then
    for f in $(cat $incf)
    do
        cat $MMIX_INC/$f >> $fnw
    done
fi
#
cp $fnw $src
mmixal -l $lst -o $obj $src
cp $incsave $src
