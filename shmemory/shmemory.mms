// -------------------------------------------------------------------
          LOC    9B                 // Data start
          GREG   @
SHMEMPARM OCTA   LOWNYBS            // Start address to dump
//SHMEMPARM OCTA   Stack_Segment            // Start address to dump
          OCTA   2                 // Length to dump
9H        IS     @                  // Data End
// -------------------------------------------------------------------
          LOC    8B                 // Code start
Main      IS     @
//        Call Memory show (print) routine
          LDA    $1,SHMEMPARM       // Parms address (subr $0)
          PUSHJ  $0,SHMEMORY        // Call subroutine
//        Return to OS
          TRAP   0,Halt,0           // Exit
8H        IS     @                  // Code End
