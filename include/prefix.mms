//*BEGIN prefix.mms
//--------------------------------------------------------------------
// Start Data Segment
         LOC    Data_Segment
         GREG   @                   // Start date base
//--------------------------------------------------------------------
// Subroutine gregister assignementss
// 32 Base
cr32     IS     $32
pr32a    IS     $33
pr32b    IS     $34
pr32c    IS     $35
// 16 Base
cr16     IS     $15
pr16a    IS     $17
pr16b    IS     $18
pr16c    IS     $195
// 8 Base
cr8      IS     $8
pr8a     IS     $9
pr8b     IS     $10
pr8c     IS     $11
// 4 Base
cr4      IS     $8
pr4a     IS     $6
pr4b     IS     $6
pr4c     IS     $7
9H       IS     @ // End data
//--------------------------------------------------------------------
         LOC    #100 // Start code
8H       IS     @
/--------------------------------------------------------------------
//*END prefix.mms
