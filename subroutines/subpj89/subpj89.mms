//*BEGIN subpj89.mms
//
// Demonstrate interleaving of data and instructions
//
// See page 7, section 16 of the MMIXWare documentation, where this 
// technique is suggested.
//
// Start of definitions is coded in the prefix.mms file which is
// included by make.  This technique is used throughout the examples in
// this reposiroty.
//
// Change to Data
          LOC   9B
Starting  BYTE  "Starting ....",#a,0
Ending    BYTE  "Ending ....",#a,0
9H        IS    @

// Change to Code
          LOC   8B
Main      LDA   $255,Starting       // Address of start message
          TRAP  0,Fputs,StdOut      // Write it
//
          PUSHJ $0,SendM1A          // Call Subroutine
          PUSHJ $0,SendM2A          // Call Subroutine
//
          LDA   $255,Ending         // Address of end message
          TRAP  0,Fputs,StdOut      // Write it
          TRAP  0,Halt,0            // Exit
8H        IS    @

// Change to Data
          LOC   9B
Sub1Msg   BYTE  "Message from routine one",#a,0
9H        IS    @

// Change to Code
          LOC   8B
SendM1A   LDA   $255,Sub1Msg        // Message Address
          TRAP  0,Fputs,StdOut      // Write it
          POP   0,0                 // Return
8H        IS    @

// Change to Data
          LOC   9B
Sub2Msg   BYTE  "Message from routine two",#a,0
9H        IS    @

// Change to Code
          LOC   8B
SendM2A   LDA   $255,Sub2Msg        // Message Address
          TRAP  0,Fputs,StdOut      // Write it
          POP   0,0                 // Return
8H        IS    @
//*BEGIN subpj89.mms
