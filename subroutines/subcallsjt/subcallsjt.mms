//*BEGIN subcallsjt.mms
//
// Demonstrate simple style of jump tables.
//
         LOC   9B                  // Code
JumpTab  LOC   @
         JMP   SendM1A             // Routine 1
         JMP   SendM2A             // Routine 2
         JMP   SendM3A             // Routine 3
         JMP   SendM4A             // Routine 4
         JMP   SendM5A             // Routine 5
NumJent  IS    (@-JumpTab)/4             // Number of entries
// ------------------------------------------------------------
Main     LOC   @
         GETA  $255,Starting       // Address of start message
         TRAP  0,Fputs,StdOut      // Write it
//
         SETL  $4,NumJent          // Entry Count
         SETL  $3,0                // First Routine Index
         GETA  $1,JumpTab          // Jump Table Address
1H       SLU   $2,$3,2             // * 4
         ADDU  $0,$1,$2            // Point to Table Entry
         GO    $0,$0,0             // Call it
         ADDU  $3,$3,1             // Increment Call Index
         SUBU  $4,$4,1             // Decrement Entry Count
         PBP   $4,1B               // Loop for all entries
//
         GETA  $255,Ending         // Address of end message
         TRAP  0,Fputs,StdOut      // Write it
         TRAP  0,Halt,0            // Exit
// ------------------------------------------------------------
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
SendM4A  GETA  $255,Sub4Msg        // Message Address
         TRAP  0,Fputs,StdOut      // Write it
         GO    $0,$0,0             // Return
//
SendM5A  GETA  $255,Sub5Msg        // Message Address
         TRAP  0,Fputs,StdOut      // Write it
         GO    $0,$0,0             // Return
// ------------------------------------------------------------
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
//
         LOC   4*((@+3)/4)         // TETRA Align
Sub4Msg  BYTE  "Message from routine four",#a,0
//
         LOC   4*((@+3)/4)         // TETRA Align
Sub5Msg  BYTE  "Message from routine five",#a,0
//*BEGIN subcallsjt.mms
