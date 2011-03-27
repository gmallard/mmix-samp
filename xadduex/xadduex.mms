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

