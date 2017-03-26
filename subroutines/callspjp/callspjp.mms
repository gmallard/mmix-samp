//*BEGIN callspj.mms
//
// Demonstrate a more comples style of subrutine kinjage,
// One of several styles supported by MMIX.
//
// Subtroutines here expect will prode one or more input parameters
// (in registers), and receive 1 or more outputs (also in registers).
//
// We will attempt to describe  register renumbering in comments,
//
// For this example we will use the $8 subruine registers defined in
//prefix.mms
// Data:
         LOC   9B
//
         GREG  @
Starting BYTE  "Starting ....",#a,0
Ending   BYTE  "Ending ....",#a,0
Sub1Msg  BYTE  "Message from routine one",#a,0
9H       IS    @
// Code
         LOC   8B                  // Code
Main     LDA   $255,Starting       // Address of start message
         TRAP  0,Fputs,StdOut      // Write it
// Set up parapmeter registers
         SET   pr8a,#1111          // Parameter register 1
                                   // This becomes $0 in the subroutime
         SET   pr8b,#2222          // Parameter register 1
                                   // This becomes $1 in the subroutime
         SET   pr8c,#3333          // Parameter register 1
                                   // This becomes $2 in the subroutime
// Call the subroutine (this is one of two styles that may be used).
         PUSHJ cr8,SendM1A          // Call Subroutine
// Here note:
// Registers lower than cr8 ($8) are untouched.  The subroutine has
// no access to them.
// The two registers actually returned are:
// pr8a ($9) - #7777
// pr8b ($10) - #8888
         LDA   $255,Ending         // Address of end message
         TRAP  0,Fputs,StdOut      // Write it
         TRAP  0,Halt,0            // Exit
//
SendM1A  IS    @
// Here Examine:
// $0 - it is #1111 (pr8a from the call)
// $1 - it is #2222 (pr8b from the call)
// $2 - it is #1111 (pr8c from the call)
         LDA   $255,Sub1Msg        // Message Address
         TRAP  0,Fputs,StdOut      // Write it
// Now, we want to return 2 registers of data.
// So we will use POP  2,0 to indicate that 2 regs are returned.
// However, we need to set those return registers up. 
// Return registers start at $0 in the subroutine.  So here they are
// $0 and $1.
         SET   $0,#7777            // Return param 1
         SET   $2,#8888            // Return param 2
         POP   2,0                 // Return 2 regs
//
8H       IS    @
//
//*END callspj.mms
