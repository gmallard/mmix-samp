#
         LOC   Data_Segment
         GREG  @
DATA1    OCTA  0
         LOC   @+128
DATA2    OCTA  1
#        We can move back
         LOC   @-64
DATA3    OCTA  3
#        This:
#        a) does _not_ go to the 'end', instead it goes to the
#        very beginning again.
#        b) Changes location from the Data_Segment to low storage!!
         LOC
MOREDATA BYTE  "X"
#        Then this goes back to the Data_segment
         LOC   DATA2+8
DATA4    TETRA #1234
#
#        I cannot think of a way to have LOC move to the 'largest
#        currently used location plus one' (plus stay in the same
#        segment).
#

#
         LOC   #100
Main     GETA  $255,String         Point to String
         TRAP  0,Fputs,StdOut      Write it
         TRAP  0,Halt,0            Exit
String   BYTE  " Hello, World!",#a,0 String with newline/terminator

