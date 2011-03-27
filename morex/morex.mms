// MOR (and some MXOR) examples.
//
// Watch with: mmix -i morex.mmo

// Start Data Segment
          LOC   Data_Segment
          GREG  @                   // Base Register
9H        IS    @
// Start Code/Text Segment
          LOC   #100
8H        IS    @
// -------------------------------------------------------------------
// Data
          LOC   9B
SEQBYTEM  OCTA  #0102030405060708  // Sequential bytes mask
9H        IS    @

// Code
          LOC   8B
Main      IS    @
          PUSHJ $0,NZZDISP         // Non-zero Z field code
          PUSHJ $0,BCOPYDISP       // Byte Copy Only
          TRAP  0,Halt,0           // Exit
8H        IS    @

// Code
          LOC   8B
NZZDISP   IS    @
          LDOU  $2,SEQBYTEM
          MOR   $3,$2,#01
          MOR   $4,$2,#03
          MOR   $5,$2,#ff
          MOR   $6,$2,#fe
          POP   0,0
8H        IS    @

// -------------------------------------------------------------------
// Data
          LOC   9B
BYTECOPYM OCTA  #8040201008040201  // Straight extract
BYTEMTEST OCTA  #01020304050607f8  // Data
9H        IS    @

// Code
          LOC   8B
BCOPYDISP IS    @
# -----------------------------------
          LDOU   $1,BYTECOPYM   // Byte copy mask
          LDOU   $2,BYTEMTEST   // Test Pattern
          MOR    $3,$2,$1       // MOR
          MXOR   $4,$2,$1       // MXOR (S/B Same)
          POP   0,0
8H        IS    @

