#
# A first very simple example of a table scan.
# Scan is from low memory address up.
# Does not use a count register.
#
         LOC   Data_Segment
         GREG  @
T1BEG    BYTE  "AB"
         BYTE  "CD"
T1LST    BYTE  "DE"
ENTLEN   IS    2
         LOC   4*((@+3)/4)
String   BYTE  "Hello, world:"
         BYTE  " "
OBYTE    BYTE  "XY"                # Must be WYDE aligned!
# Or Strange Results!
         BYTE  #a,0                # End Of the Line
#
         LOC   #100
Main     LDA   $255,String         Point to String
         TRAP  0,Fputs,StdOut      Write it
#
         LDA   $4,T1BEG            First entry Address
         LDA   $5,T1LST            Last Entry Address
3H       LDWU  $3,$4,0             Get Next Two Bytes
         STWU  $3,OBYTE            Save em
         LDA   $255,String         Point to String
         TRAP  0,Fputs,StdOut      Write it
         ADDU  $4,$4,ENTLEN        Bump to next entry
         CMP   $0,$4,$5            There yet?
         PBNP  $0,3B               Loop For Entries
#
         TRAP  0,Halt,0            Exit


