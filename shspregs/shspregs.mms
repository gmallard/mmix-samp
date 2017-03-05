// -------------------------------------------------------------------
// Data
          LOC    9B
          LOC    @+(8-@)&7 // OCTA Align

// Dump memory parameters:
//    - OCTA 1 - The start Address
//    - OCTA 2 - The length in bytes         
SHMEMPARM OCTA   LOWNYBS    // For this demo
SHMEMLEN  OCTA   16         // For this demo

9H        IS     @
// -------------------------------------------------------------------
// Code
          LOC    8B
Main      IS     @
//****
          LDA    $1,SHMEMPARM       // Parms address
          PUSHJ  $0,SHMEMORY        // Call mem dumper
// Return to OS
          TRAP   0,Halt,0           // Exit
8H        IS     @
