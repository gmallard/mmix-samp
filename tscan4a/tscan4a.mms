#
# A first very simple example of a table scan.
# Scan is from high memory address down.
# Does not use a count register.
# Does not use a compare instruction.
#
# More in the Knuth style ??
#
         LOC   Data_Segment
         GREG  @
T1BEG    BYTE  "AB"
         BYTE  "CD"
T1LST    BYTE  "DE"
ENTLEN   IS    2
LASTOPLN IS    T1LST+ENTLEN-T1BEG    
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
         SET   $4,LASTOPLN         One past index of last
         LDA   $5,T1BEG            Base address
         JMP   9F                  Go to decrement 1st time
3H       LDWU  $3,$5,$4            Get Next Two Bytes
         STWU  $3,OBYTE            Save em
         LDA   $255,String         Point to String
         TRAP  0,Fputs,StdOut      Write it
9H       SUBU  $4,$4,ENTLEN        Decr Entry Pointer
         PBNN  $4,3B               No, Loop For Entries
#
         TRAP  0,Halt,0            Exit


