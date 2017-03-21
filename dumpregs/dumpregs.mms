//*BEGIN dumpregs.mms
9H        IS     @                   // 9B/9H for data start/end
// Start Code/Text Segment
// -------------------------------------------------------------------
// Code
          LOC    8B                 // Code start
Main      IS     @
//        Return to OS
          SET    $1,#1111          // For this test
          SET    $2,#2222          // For this test
          PUSHJ  $0,DumpRegs       // Dump Registers
          TRAP   0,Halt,0          // Exit
8H        IS     @                 // Code End
//*END dumpregs.mms
