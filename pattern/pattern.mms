// Start Data Segment
          LOC    Data_Segment
          GREG   @                   // Base Register
9H        IS     @                   // 9B/9H for data start/end
// Start Code/Text Segment
          LOC    #100
8H        IS     @                   // 8B/8H for code start/end

9H        IS     @                  // Data end
// -------------------------------------------------------------------
// Code
          LOC    8B                 // Code start
Main      IS     @
//        Call Memory show (print) routine
          PUSHJ  $0,PATTERNC
//        Return to OS
          TRAP   0,Halt,0          // Exit
8H        IS     @                 // Code End
