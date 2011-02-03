#
# A first very simple example of a table scan.
# Scan is from high memory address down.
#
         LOC   Data_Segment
         GREG  @
T1BEG    BYTE  "AB"
         BYTE  "CD"
T1LST    BYTE  "DE"
ENTLEN   IS    2
NUMENT   IS    1+(T1LST-T1BEG)/ENTLEN
         LOC   4*((@+3)/4)
String   BYTE  "Hello, world:"
         BYTE  " "
OBYTE    BYTE  "XY"    Must be WYDE aligned! Or Strange Results!
         BYTE  #a,0 String with newline and terminator
#
         LOC   #100
Main     LDA   $255,String         Point to String
         TRAP  0,Fputs,StdOut      Write it
#
         LDA   $4,T1LST            First entry Address
         SETL  $5,NUMENT           Number of entries
         JMP   3F                  Merge
2H       SUBU  $4,$4,ENTLEN        Decr next entry address
3H       LDWU  $3,$4,0             Get Next Two Bytes
         STWU  $3,OBYTE            Save em
         LDA   $255,String         Point to String
         TRAP  0,Fputs,StdOut      Write it
         SUBU  $5,$5,1             Decr Entry Count
         PBP   $5,2B               Loop For Entries
#
         TRAP  0,Halt,0            Exit


