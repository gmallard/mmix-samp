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
          PUSHJ $0,LOW2BDISP       // 2-byte merge
          PUSHJ $0,MRGBBDISP       // Multi byte merge
          PUSHJ $0,MCMPBDISP       // More complex data
          TRAP  0,Halt,0           // Exit
8H        IS    @

// Code
          LOC   8B
// The immediate form MOR $X,$Y,Z always sets the leading seven
// bytes of register X to zero; the other byte is set to the
// bitwise or of whatever bytes of register Y are specified by
// the immediate operand Z.)
NZZDISP   IS    @
          LDOU  $2,SEQBYTEM
          MOR   $3,$2,#01          // -> #08
          MOR   $4,$2,#03          // -> #0f (#07 | #08)
          MOR   $5,$2,#ff          // -> #0f (#01 | ... | #08)
          MOR   $6,$2,#fe          // -> #07 (#01 | ... | #07) 
          POP   0,0
8H        IS    @

// -------------------------------------------------------------------
// Data
          LOC   9B
// The bits in the mask bytes ($Z) specify which bytes to use from
// the $Y field.  This example is just a 'copy' of all the bytes
// from $Y (#01020304050607f8)
BYTECOPYM OCTA  #8040201008040201  // Straight extract
BYTEMTEST OCTA  #01020304050607f8  // Data
9H        IS    @

// Code
          LOC   8B
BCOPYDISP IS    @
# -----------------------------------
          LDOU   $1,BYTECOPYM   // Byte copy mask
          LDOU   $2,BYTEMTEST   // Test Pattern
          MOR    $3,$2,$1       // MOR: -> #01020304050607f8
          MXOR   $4,$2,$1       // MXOR (Also) -> #01020304050607f8
          POP   0,0
8H        IS    @

// -------------------------------------------------------------------
// Data
          LOC   9B
BYTE2LOWM OCTA  #8040201008040202  // Two low bytes
9H        IS    @

// Code
          LOC   8B
LOW2BDISP IS    @
          LDOU  $1,BYTE2LOWM   // Byte copy mask
          LDOU  $2,BYTECOPYM   // Test Pattern from old mask
          MOR   $3,$2,$1       // MOR -> #8040201008040202
          MXOR  $4,$2,$1       // MXOR (Also) -> #8040201008040202
          POP   0,0
8H        IS    @

// -------------------------------------------------------------------
// Data
          LOC   9B
SEQNDATA  OCTA  #0102030405060708  # Data
FIDDLEDAT OCTA  #80402010080402ff  # Not so straight extract
 OCTA  #ffffffffffffffff  // Not so straight extract
 OCTA  #0000000000000000  // Not so straight extract => 0, 0
 OCTA  #0000000000000001  // Not so straight extract => 8, 8
 OCTA  #0000000000000002  // Not so straight extract => 7, 7
 OCTA  #0000000000000003  // Not so straight extract => f, f
 OCTA  #0000000000000004  // Not so straight extract => 6, 6
 OCTA  #0000000000000005  // Not so straight extract => e, e
 OCTA  #0000000000000006  // Not so straight extract => 7, 1
 OCTA  #0000000000000007  // Not so straight extract => f, 9
 OCTA  #0000000000000008  // Not so straight extract => 5, 5
 OCTA  #0000000000000009  // Not so straight extract => d, d
 OCTA  #000000000000000a  // Not so straight extract => 7, 2
 OCTA  #000000000000000b  // Not so straight extract => f, a
 OCTA  #000000000000000c  // Not so straight extract => 7, 3
 OCTA  #000000000000000d  // Not so straight extract => f, b
 OCTA  #000000000000000e  // Not so straight extract => 7, 4
 OCTA  #000000000000000f  // Not so straight extract => f, c
FDATTNENT IS    (@-FIDDLEDAT)/8
9H        IS    @

// Code
          LOC   8B
MRGBBDISP IS    @
          SETL  $0,FDATTNENT    // Counter
          LDA   $1,FIDDLEDAT    // Table address
0H        LDOU  $2,$1,0         // Next Mask
          LDOU  $3,SEQNDATA     // Test data
          MOR   $4,$3,$2        // MOR
          MXOR  $5,$3,$2        // MXOR (S/B Same)
//
          ADDU  $1,$1,8         // Incr mask address
          SUBU  $0,$0,1         // Decrement count
          PBP   $0,0B           // Loop for all entries
          POP   0,0
8H        IS    @

// -------------------------------------------------------------------
// Data
          LOC   9B
CLMPDATA0 OCTA  #000000000001aa5d  # Data
CMPLDMSK  OCTA  #0000000000000003  # Not so straight extract
9H        IS    @

// Code
          LOC   8B
MCMPBDISP IS    @
          LDOU  $3,CLMPDATA0    // Data
          LDOU  $2,CMPLDMSK     // Mask
          MOR   $4,$3,$2        // MOR
          MXOR  $5,$3,$2        // MXOR
          POP   0,0
8H        IS    @

