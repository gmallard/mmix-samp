//*BEGIN subcalls.mms
//
// Demonstrate simple style of subroutine linkage.  
// One of several styles supported by MMIX.
//
// Knuth indicates this is commonly used 'on machines that have no
// built-in register stack mechanism.'
//
         LOC   9B                  // Bacck to code
Main     GETA  $255,Starting       // Address of start message
         TRAP  0,Fputs,StdOut      // Write it
//
         GETA  $0,SendM1A          // Sub Addr
         GO    $0,$0,0             // Call it
//
         GETA  $0,SendM2A          // Sub Addr
         GO    $0,$0,0             // Call it
//
         GETA  $0,SendM3A          // Sub Addr
         GO    $0,$0,0             // Call it
//
         GETA  $255,Ending         // Address of end message
         TRAP  0,Fputs,StdOut      // Write it
         TRAP  0,Halt,0            // Exit
//
SendM1A  GETA  $255,Sub1Msg        // Message Address
         TRAP  0,Fputs,StdOut      // Write it
         GO    $0,$0,0             // Return
//
SendM2A  GETA  $255,Sub2Msg        // Message Address
         TRAP  0,Fputs,StdOut      // Write it
         GO    $0,$0,0             // Return
//
SendM3A  GETA  $255,Sub3Msg        // Message Address
         TRAP  0,Fputs,StdOut      // Write it
         GO    $0,$0,0             // Return
//
Starting BYTE  "Starting ....",#a,0
//
         LOC   4*((@+3)/4)         // TETRA Align
Ending   BYTE  "Ending ....",#a,0
//
         LOC   4*((@+3)/4)         // TETRA Align
Sub1Msg  BYTE  "Message from routine one",#a,0
//
         LOC   4*((@+3)/4)         // TETRA Align
Sub2Msg  BYTE  "Message from routine two",#a,0
//
         LOC   4*((@+3)/4)         // TETRA Align
Sub3Msg  BYTE  "Message from routine three",#a,0
//*END subcalls.mms
