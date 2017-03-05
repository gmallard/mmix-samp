// -------------------------------------------------------------------
// Code
          LOC    8B
Main      IS     @
//****
          PUSHJ  $0,SHSPREGS        // Call SP Reg dumper
// Return to OS
          TRAP   0,Halt,0           // Exit
8H        IS     @
