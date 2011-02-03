         LOC   Data_Segment
         GREG  @
INBUFF   BYTE  "__"                Two byte buffer
         BYTE  #a,0                EOL
#
# Simple Fread demonstration.
# 1) Assemble and Link
# 2) Run with: mmix fread1.mmo
# 3) After the 'Starting' message appears:
# 3.a) Key in one or two (or more characters)
# 3.b) Press enter
#
# Alternatively:
# 1) Assemble and Link
# 2) Run with: mmix -fdata.txt fread1.mmo
#
         LOC   #100
Main     GETA  $255,Starts         Point to string
         TRAP  0,Fputs,StdOut      Write it
#
         GETA  $255,ReadParm       Fread Parms
         TRAP  0,Fread,StdIn       READ the line
#
         LDA   $255,INBUFF         Point to string
         TRAP  0,Fputs,StdOut      Write it
#
         GETA  $255,Ends           Point to string
         TRAP  0,Fputs,StdOut      Write it
         TRAP  0,Halt,0            Exit
Starts   BYTE  "Starting",#a,0
         LOC   4*((@+3)/4)
Ends     BYTE  "Ending",#a,0
ReadParm OCTA  INBUFF,2

