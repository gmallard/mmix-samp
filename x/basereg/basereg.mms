// Start Data Segment
         LOC    Data_Segment
//
//////// GREG   @                   // OK
//*No BaseBrg1 GREG   String
//*No         GREG   String
BaseBrg1 GREG   @                   // OK
//*OK BaseBrg2 GREG   @+256               //
//*OK BaseBrg3 GREG   @+512               //
//*OK BaseBrg4 GREG   @+768               //
String   BYTE   "Hello, world",#a,0
9H       IS     @
// Start Code/Text Segment
         LOC    #100
8H       IS     @
// -------------------------------------------------------------------
// Code
         LOC    8B
Main     IS     @
         LDA    $255,String
         TRAP   0,Fputs,StdOut
         TRAP   0,Halt,0
