// An exploration of the xADDU instructions.
// Per the documentation:
//
// It is faster to execute 2ADDU $Y,$X,$X than it is to multiply by 3
// if overflow is not an issue.

// Start Data Segment
          LOC   Data_Segment
          GREG  @                   // Base Register
9H        IS    @
// Start Code/Text Segment
          LOC   #100
8H        IS    @
// -------------------------------------------------------------------

// First, some instruction timings, per documentation:
//
// MULU - 10u
// SLU - 1u
// 2ADDU - 1u
// 4ADDU - 1u
// 8ADDU - 1u
// 16ADDU - 1u
//
// So ..... in the example from the documentation, we save 9u.  
// Impressive.
//
// Trade off between MULU and multiple xADDU's is instruction space 
// memory.

// For now, let us consider the cases of multiplication by numbers in
// the range: 2...32.
//
// Input data: 42 (decimal) in all cases.
//
// Expected results:
// i:2 Result: 84 == 0x54
// i:3 Result: 126 == 0x7e
// i:4 Result: 168 == 0xa8
// i:5 Result: 210 == 0xd2
// i:6 Result: 252 == 0xfc
// i:7 Result: 294 == 0x126
// i:8 Result: 336 == 0x150
// i:9 Result: 378 == 0x17a
// i:10 Result: 420 == 0x1a4
// i:11 Result: 462 == 0x1ce
// i:12 Result: 504 == 0x1f8
// i:13 Result: 546 == 0x222
// i:14 Result: 588 == 0x24c
// i:15 Result: 630 == 0x276
// i:16 Result: 672 == 0x2a0
// i:17 Result: 714 == 0x2ca
// i:18 Result: 756 == 0x2f4
// i:19 Result: 798 == 0x31e
// i:20 Result: 840 == 0x348
// i:21 Result: 882 == 0x372
// i:22 Result: 924 == 0x39c
// i:23 Result: 966 == 0x3c6
// i:24 Result: 1008 == 0x3f0
// i:25 Result: 1050 == 0x41a
// i:26 Result: 1092 == 0x444
// i:27 Result: 1134 == 0x46e
// i:28 Result: 1176 == 0x498
// i:29 Result: 1218 == 0x4c2
// i:30 Result: 1260 == 0x4ec
// i:31 Result: 1302 == 0x516
// i:32 Result: 1344 == 0x540

// Implementation Strategy:
//
// Let's cherry pick first.  It is clearly easy to implement:
// - 2*$x
// - 3*$x
// - 4*$x
// - 5*$x
// - 8*$x
// - 9*$x
// - 16*$x
// - 17*$x
// with a single instruction.
//

// Data - Pattern
          LOC   9B
9H        IS    @

// Code - Pattern
          LOC   8B
Main      IS    @
8H        IS    @

// Code
          LOC   8B
Main      IS    @
          PUSHJ $0,Mult02           // Next Multiply Example
          PUSHJ $0,Mult03           // Next Multiply Example
          PUSHJ $0,Mult04           // Next Multiply Example
          PUSHJ $0,Mult05           // Next Multiply Example
          PUSHJ $0,Mult06           // Next Multiply Example
          PUSHJ $0,Mult07           // Next Multiply Example
          PUSHJ $0,Mult08           // Next Multiply Example
          PUSHJ $0,Mult09           // Next Multiply Example
//
          PUSHJ $0,Mult10           // Next Multiply Example
          PUSHJ $0,Mult11           // Next Multiply Example
          PUSHJ $0,Mult12           // Next Multiply Example
          PUSHJ $0,Mult13           // Next Multiply Example
          PUSHJ $0,Mult14           // Next Multiply Example
          PUSHJ $0,Mult15           // Next Multiply Example
          PUSHJ $0,Mult16           // Next Multiply Example
          PUSHJ $0,Mult17           // Next Multiply Example
          PUSHJ $0,Mult18           // Next Multiply Example
          PUSHJ $0,Mult19           // Next Multiply Example
//
          PUSHJ $0,Mult20           // Next Multiply Example
          PUSHJ $0,Mult21           // Next Multiply Example
          PUSHJ $0,Mult22           // Next Multiply Example
          PUSHJ $0,Mult23           // Next Multiply Example
          PUSHJ $0,Mult24           // Next Multiply Example
          PUSHJ $0,Mult25           // Next Multiply Example
          PUSHJ $0,Mult26           // Next Multiply Example
          PUSHJ $0,Mult27           // Next Multiply Example
          PUSHJ $0,Mult28           // Next Multiply Example
          PUSHJ $0,Mult29           // Next Multiply Example
//
          PUSHJ $0,Mult30           // Next Multiply Example
          PUSHJ $0,Mult31           // Next Multiply Example
          PUSHJ $0,Mult32           // Next Multiply Example
          TRAP  0,Halt,0            // Exit
8H        IS    @
// Code
          LOC   8B
Mult02    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,2             // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult03    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,3             // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult04    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,4             // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult05    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,5             // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult06    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,6             // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult07    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,7             // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult08    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,8             // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult09    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,9             // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult10    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,10            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult11    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,11            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult12    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,12            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult13    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,13            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult14    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,14            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult15    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,15            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult16    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,16            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult17    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,17            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult18    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,18            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult19    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,19            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult20    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,20            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult21    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,21            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult22    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,22            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult23    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,23            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult24    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,24            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult25    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,25            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult26    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,26            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult27    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,27            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult28    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,28            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult29    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,29            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult30    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,30            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult31    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,31            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult32    IS    @
          SETL  $2,42               // Data
          MULU  $0,$2,32            // TODO: replace
          POP   1,0                 // Result in $0
8H        IS    @
