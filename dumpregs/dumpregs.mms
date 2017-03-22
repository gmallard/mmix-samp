//*BEGIN dumpregs.mms
9H        IS     @                   // 9B/9H for data start/end
// Start Code/Text Segment
// -------------------------------------------------------------------
// Code
          LOC    8B                 // Code start
Main      IS     @
//        Return to OS
          SET    $0,#1234          // For this demo
          SET    $1,#1111          // For this demo
          SET    $2,#2222          // For this demo
          SET    $3,#3333          // For this demo
          SET    $4,#4444          // For this demo
          SET    $5,#5555          // For this demo
          SET    $6,#6666          // For this demo
          SET    $7,#7777          // For this demo
          SET    $8,#8888          // For this demo
          SET    $9,#9999          // For this demo
          SET    $10,#aaaa         // For this demo
          SET    $11,#bbbb         // For this demo
          SET    $12,#cccc         // For this demo
          SET    $13,#dddd         // For this demo
          SET    $14,#eeee         // For this demo
          SET    $15,#ffff         // For this demo
//
          SET    $16,#4567         // For this demo
          SET    $17,#ffff         // For this demo
          SET    $18,#eeee         // For this demo
          SET    $19,#dddd         // For this demo
          SET    $20,#cccc         // For this demo
          SET    $21,#bbbb         // For this demo
          SET    $22,#aaaa         // For this demo
          SET    $23,#9999         // For this demo
          SET    $24,#8888         // For this demo
          SET    $25,#7777         // For this demo
          SET    $26,#6666         // For this demo
          SET    $27,#5555         // For this demo
          SET    $28,#4444         // For this demo
          SET    $29,#3333         // For this demo
          SET    $30,#2222         // For this demo
          SET    $31,#1111         // For this demo
//
          GETA   $32,DumpRegs      // Sub Addr
          GO     $32,$32,0         // Dump $0 ... $31
          TRAP   0,Halt,0          // Exit
8H        IS     @                 // Code End
//*END dumpregs.mms
