// -------------------------------------------------------------------
          LOC    9B                 // Data start
          GREG   @
SHMEMPARM OCTA   PATBUFF            // Start address to dump
          OCTA   256                // Length to dump
9H        IS     @                  // Data End
// -------------------------------------------------------------------
          LOC    8B                 // Code start
Main      IS     @
//        Call Memory show (print) routine
          LDOU   $1,SHMEMPARM       // Parms address (subr $0)
          LDOU   $2,SHMEMPARM+8     // Length (subr $1)
          PUSHJ  $0,SHMEMORY        // Call subroutine
//        Return to OS
          TRAP   0,Halt,0           // Exit
8H        IS     @                  // Code End
