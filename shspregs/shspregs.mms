// -------------------------------------------------------------------
// Data
          LOC    9B
          GREG   @
LOWNYBS   OCTA   #0f0f0f0f0f0f0f0f
HEXTRTABL BYTE   "0123456789abcdef"
DUMMYDATA OCTA   #1234567890abcdef
BYTELODMS OCTA   #0000000000000008
9H        IS     @
// -------------------------------------------------------------------
// Code
          LOC    8B
Main      IS     @
//****
          PUSHJ  $0,SHSPREGS
// Return to OS
          TRAP   0,Halt,0            // Exit
8H        IS     @
