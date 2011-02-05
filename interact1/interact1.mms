#
# Assemble and link.
# Run withL mmix -i interact1.mmo
#
# During the interactive session use:
#
# isr.txt
#
# to show registers of interest.
#
# Results of this are in the comments below.
#
# This exercise primarily shows a couple of ways to use BDIF.
#

         LOC   Data_Segment
         GREG  @
VALUE1   OCTA  #0102030405060708
VALUE2   OCTA  #0807060504030201
#
a        IS    $1
b        IS    $2
c        IS    $3
d        IS    $4
e        IS    $5
x        IS    $6
y        IS    $7
#

#
         LOC   #100

Main     PUSHJ $0,MinMax
         PUSHJ $0,PixDiff
#
         GETA  $255,String         Point to String
         TRAP  0,Fputs,StdOut      Write it
         TRAP  0,Halt,0            Exit

###############################################
MinMax   LDOU  a,VALUE1            Get 1st value
#
# $1=l[2]=#102030405060708
# $2=#0
# $3=#0
# $4=#0
# $5=#0
# $6=#0
# $7=#0
#
         LDOU  b,VALUE2            Get second value
#
# $1=l[2]=#102030405060708
# $2=l[3]=#807060504030201
# $3=#0
# $4=#0
# $5=#0
# $6=#0
# $7=#0
#
#
#        Subtract each byte.
#        Result Byte = 0 if negative
#        Result byte = value if positive
#
         BDIF  x,a,b               Byte difference
#
# $1=l[2]=#102030405060708
# $2=l[3]=#807060504030201
# $3=l[4]=#0
# $4=l[5]=#0
# $5=l[6]=#0
# $6=l[7]=#1030507
# $7=#0
#
#        Add byte difference to second value
         ADDU  c,x,b               Added with b
#
# c = $3 = bytewise maxima
# $1=l[2]=#102030405060708
# $2=l[3]=#807060504030201
# $3=l[4]=#807060505060708
# $4=l[5]=#0
# $5=l[6]=#0
# $6=l[7]=#1030507
# $7=#0
#
#        subtract byte difference from first value
         SUBU  d,a,x               Subtracted from a
#
# d = $4 = bytewise minima
# $1=l[2]=#102030405060708
# $2=l[3]=#807060504030201
# $3=l[4]=#807060505060708
# $4=l[5]=#102030404030201
# $5=l[6]=#0
# $6=l[7]=#1030507
# $7=#0
#
         POP   0,0
###############################################

###############################################
PixDiff  LDOU  a,VALUE1            Get 1st value
#
# $1=l[2]=#102030405060708
# $2=#0
# $3=#0
# $4=#0
# $5=#0
# $6=#0
# $7=#0
#
         LDOU  b,VALUE2            Get 2nd value
#
# $1=l[2]=#102030405060708
# $2=l[3]=#807060504030201
# $3=#0
# $4=#0
# $5=#0
# $6=#0
# $7=#0
#
         BDIF  x,a,b               Byte Diff: a - b
#
# $1=l[2]=#102030405060708
# $2=l[3]=#807060504030201
# $3=l[4]=#0
# $4=l[5]=#0
# $5=l[6]=#0
# $6=l[7]=#1030507
# $7=#0
#
         BDIF  y,b,a               Byte Diff: b - a
#
# $1=l[2]=#102030405060708
# $2=l[3]=#807060504030201
# $3=l[4]=#0
# $4=l[5]=#0
# $5=l[6]=#0
# $6=l[7]=#1030507
# $7=l[8]=#705030100000000
#
         OR    e,x,y               Merge/OR together
#
# e = $5 = (pixel differences)absolute value of the differences
# between the individual bytes
# $1=l[2]=#102030405060708
# $2=l[3]=#807060504030201
# $3=l[4]=#0
# $4=l[5]=#0
# $5=l[6]=#705030101030507
# $6=l[7]=#1030507
# $7=l[8]=#705030100000000
#
         POP   0,0
###############################################


String   BYTE  "Done",#a,0      String with newline and terminator

