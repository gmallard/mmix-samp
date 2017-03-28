// -------------------------------------------------------------------
// Code
          LOC    8B                 // Code start
Main      IS     @
//        Call Memory show (print) routine
          PUSHJ  $0,PATTERNC
//        Return to OS
          TRAP   0,Halt,0          // Exit
8H        IS     @                 // Code End
