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
// ADDU - 1u
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
// i:2 Result: 84 == 0x54 (*DONE) (1 instruction)
// i:3 Result: 126 == 0x7e (*DONE) (1 instruction)
// i:4 Result: 168 == 0xa8 (*DONE) (1 instruction)
// i:5 Result: 210 == 0xd2 (*DONE) (1 instruction)
// i:6 Result: 252 == 0xfc (*DONE)
// i:7 Result: 294 == 0x126 (*DONE)
// i:8 Result: 336 == 0x150 (*DONE) (1 instruction)
// i:9 Result: 378 == 0x17a (*DONE) (1 instruction)
// i:10 Result: 420 == 0x1a4 (*DONE)
// i:11 Result: 462 == 0x1ce (*DONE)
// i:12 Result: 504 == 0x1f8 (*DONE)
// i:13 Result: 546 == 0x222 (*DONE)
// i:14 Result: 588 == 0x24c
// i:15 Result: 630 == 0x276 (*DONE)
// i:16 Result: 672 == 0x2a0 (*DONE) (1 instruction)
// i:17 Result: 714 == 0x2ca (*DONE) (1 instruction)
// i:18 Result: 756 == 0x2f4 (*DONE) 
// i:19 Result: 798 == 0x31e (*DONE) 
// i:20 Result: 840 == 0x348 (*DONE) 
// i:21 Result: 882 == 0x372 (*DONE)
// i:22 Result: 924 == 0x39c
// i:23 Result: 966 == 0x3c6
// i:24 Result: 1008 == 0x3f0 (*DONE) 
// i:25 Result: 1050 == 0x41a (*DONE)
// i:26 Result: 1092 == 0x444
// i:27 Result: 1134 == 0x46e (*DONE)
// i:28 Result: 1176 == 0x498
// i:29 Result: 1218 == 0x4c2
// i:30 Result: 1260 == 0x4ec
// i:31 Result: 1302 == 0x516
// i:32 Result: 1344 == 0x540 (*DONE) (1 instruction)

// Implementation Strategy:
//
// Let's cherry pick first.  It is clearly easy to implement:
// - 2*$x (2ADDU $R,$x,0)
// - 3*$x (2ADDU $R,$x,$x)
// - 4*$x (4ADDU $R,$x,0)
// - 5*$x (4ADDU $R,$x,$x)
// - 8*$x (8ADDU $R,$x,0)
// - 9*$x (8ADDU $R,$x,$x)
// - 16*$x (16ADDU $R,$x,0)
// - 17*$x (16ADDU $R,$x,$x)
// with a single instruction.
//
// Implement the first (least) value we do not yet have.  This is 6.
// See below for one concrete implementation, and another in comments.
//
// That is a reminder that shifts (SLU) are 1u as well, and we should
// cherry pick remaining powers of 2 (in this case, only 32 remains).
//
// What next?
//
// For any result computed in one instruction, it should be clear that
// we can multiply that result by: 2, 3, 4, 5, 8, 9, 16, 17, or 32
// with a single additional xADDU instruction.
//
// The single instruction values are the same as listed, i.e.:
// 2, 3, 4, 5, 8, 9, 16, 17, 32
//
// Let's consider those one at a time.
//
// For 2: can get -> 4 // (*DONE)
//                -> 5 // (*DONE)
// For 3: can get -> 6 // (*DONE)
//                -> 7 // (*DONE)
// For 4: can get -> 8 // (*DONE)
//                -> 9 // (*DONE)
// For 5: can get -> 10 // (*DONE)
//                -> 11 // (*DONE)
// For 8: can get -> 16 // (*DONE)
//                -> 17 // (*DONE)
// For 9: can get -> 18 // (*DONE)
//                -> 19 // (*DONE)
// For 16, 17, and 32 the results are beyond the scope of this effort,
// but could easily be demonstrated.
//
// Next, implement 'obvious' cases:
// 4+8 => 12
// 4+16 => 20
// 8+16 => 24
//
// Next, steal one from Dr. Knuth:
// => 25
//
// Try some results suggested by the output of 'addu-gen.rb', which is
// included in this project.
// => 13 (*OK)
// => 15 (*OK)
// => 21 (*OK)
// => 27 (*OK)
//
// What is left?
// 14, 22, 23, 26, 28, 29, 30

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
          2ADDU $0,$2,0             // *= 2
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult03    IS    @
          SETL  $2,42               // Data
          2ADDU $0,$2,$2            // *= 3
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult04    IS    @
          SETL  $2,42               // Data
          4ADDU $0,$2,0             // *= 4
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult05    IS    @
          SETL  $2,42               // Data
          4ADDU $0,$2,$2            // *= 5
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult06    IS    @
          SETL  $2,42               // Data
//
// Strategy 1: Timing = 2u
//          4ADDU $0,$2,$2            // *= 5
//          ADDU  $0,$0,$2            // + 1
//
// Strategy 2: Timing = 2u
          2ADDU $0,$2,$2            // *= 3
          SLU   $0,$0,1             // *= 2 ==> 6
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult07    IS    @
          SETL  $2,42               // Data
// Strategy 1: Timing = 2u
//          2ADDU $0,$2,$2            // *= 3
//          2ADDU $0,$0,$2            // *2 + 1 ==> 7
// Strategy 2: Timming = 2u
          4ADDU $0,$2,$2            // *= 5
          2ADDU $0,$2,$0            // +2
// Strategy x:  there are several (I think) other ways of implementing 
// this.
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult08    IS    @
          SETL  $2,42               // Data
          8ADDU $0,$2,0             // *= 8
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult09    IS    @
          SETL  $2,42               // Data
          8ADDU $0,$2,$2            // *= 9
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult10    IS    @
          SETL  $2,42               // Data
// Strategy 1: Timing = 2u
//          4ADDU $0,$2,$2            // *= 5
//          2ADDU $0,$0,0             // *2 => 10
// Strategy 2: Timing = 2u
          4ADDU $0,$2,$2            // *= 5
          SLU   $0,$0,1             // *2 => 10
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult11    IS    @
          SETL  $2,42               // Data
// Strategy 1: Timing = 2u
          4ADDU $0,$2,$2            // *= 5
          2ADDU $0,$0,$2            // *2 +1 => 11
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult12    IS    @
          SETL  $2,42               // Data
// Strategy 1: Timing = 2u
          4ADDU $0,$2,0             // *=4
          8ADDU $0,$2,$0            // *8 + 4 => 12
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult13    IS    @
          SETL  $2,42               // Data
          2ADDU $0,$2,$2            // *=3
          4ADDU $0,$0,$2            // *4 + 1 => 13
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
          2ADDU $0,$2,$2            // *=3
          4ADDU $0,$0,$0            // *4 + 3 => 15
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult16    IS    @
          SETL  $2,42               // Data
          16ADDU $0,$2,0            // *= 16
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult17    IS    @
          SETL  $2,42               // Data
          16ADDU $0,$2,$2           // *= 17
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult18    IS    @
          SETL  $2,42               // Data
          8ADDU $0,$2,$2            // *= 9
          2ADDU $0,$0,0             // *2 => 18
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult19    IS    @
          SETL  $2,42               // Data
          8ADDU $0,$2,$2            // *= 9
          2ADDU $0,$0,$2            // *2 +1 => 19
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult20    IS    @
          SETL  $2,42               // Data
          4ADDU $0,$2,0             // *= 4
          16ADDU $0,$2,$0           // + *16 => 20
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult21    IS    @
          SETL  $2,42               // Data
          16ADDU $0,$2,$2           // *=17
          4ADDU $0,$2,$0            // +4 => 21
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
          8ADDU $0,$2,0             // *= 8
          16ADDU $0,$2,$0           // + *16 => 24
          POP   1,0                 // Result in $0
8H        IS    @
// Code
          LOC   8B
Mult25    IS    @
          SETL  $2,42               // Data
          4ADDU $0,$2,$2            // *= 5
          4ADDU $0,$0,$0            // *4 + 1 = 25
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
          2ADDU $0,$2,$2            // *=3
          8ADDU $0,$0,$0            // *=9 => 27
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
          SLU   $0,$2,5             // *= 6 
          POP   1,0                 // Result in $0
8H        IS    @

