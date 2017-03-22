// MOR (and some MXOR) examples.
//
// Watch with: mmix -i morex.mmo
//
// -------------------------------------------------------------------
// Data
          LOC   9B
SEQBYTEM  OCTA  #0102030405060708  // Sequential bytes mask
          BYTE  "NZREG   "
NNZREG3   OCTA  0
NNZREG4   OCTA  0
NNZREG5   OCTA  0
NNZREG6   OCTA  0
//
// The bits in the mask bytes ($Z) specify which bytes to use from
// the $Y field.  This example is just a 'copy' of all the bytes
// from $Y (#01020304050607f8)
BYTECOPYM OCTA  #8040201008040201  // Straight extract ($Z)
BYTEMTEST OCTA  #01020304050607f8  // Data ($Y)
          BYTE  "BCOPYREG"
BCOPYR3   OCTA  0
BCOPYR4   OCTA  0
//
BYTE2LOWM OCTA  #8040201008040202  // Two low bytes
          BYTE  "BLOWREGS"
BLOWR3    OCTA  0
BLOWR4    OCTA  0

//
SEQNDATA  OCTA  #0102030405060708  # Data ($Y)

          LOC   @+(8-@)&7  // OCTA Align
          BYTE  "FIDDLEDT"
// These will be various $Z (mask) values
FIDDLEDAT IS    @
          BYTE  "EXPER001"
          OCTA  #80402010080402ff  # Not so straight extract
// Above: Straight 'extract byte' for bytes 0 .. 6
// Then: OR all bytes for byte 7
          BYTE  "        "
// -> #010203040506070f
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER002"
          OCTA  #ffffffffffffffff  // Not so straight extract
// Above: OR all bytes for all bytes.
// -> #0f0f0f0f0f0f0f0f
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER003"
          OCTA  #0000000000000000  // Not so straight extract
// Above: Do not OR any bytes
// -> #0000000000000000
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER004"
          OCTA  #0000000000000001  // Not so straight extract
// Above: Only OR byte 7 (#08) into byte 7
// -> #0000000000000008
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER005"
          OCTA  #0000000000000002  // Not so straight extract
// Above: Only OR byte 6 (#07) into byte 7
// -> #0000000000000007
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER006"
          OCTA  #0000000000000003  // Not so straight extract
// Above: OR bytes 6..7 (#07..#08) into byte 7
// -> #000000000000000f
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER007"
          OCTA  #0000000000000004  // Not so straight extract
// Above: Only OR byte 5 (#06) into byte 7
// -> #0000000000000006
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER008"
          OCTA  #0000000000000005  // Not so straight extract
// Above: OR bytes 5 (#06) and 7 (#08) into byte 7
// -> #000000000000000e
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER009"
          OCTA  #0000000000000006  // Not so straight extract
// Above: OR bytes 5 and 6 into byte 7
// -> #0000000000000007
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER010"
          OCTA  #0000000000000007  // Not so straight extract
// Above: OR bytes 5..7 (#06,#07,#08) into byte 7
// -> #000000000000000f
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER011"
          OCTA  #0000000000000008  // Not so straight extract
// Above: OR byte 4 (#05) into byte 7
// -> #0000000000000005
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER012"
          OCTA  #0000000000000009  // Not so straight extract
// Above: OR bytes 4 (#05) and 7 (#08) into byte 7
// -> #000000000000000d
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER013"
          OCTA  #000000000000000a  // Not so straight extract
// Above: OR bytes 4 (#05) and 6 (#07) into byte 7
// -> #0000000000000007
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER014"
          OCTA  #000000000000000b  // Not so straight extract
// Above: OR bytes 4 (#05) and 6 (#07) and 7 (#08)
// into byte 7
// -> #000000000000000f
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER015"
          OCTA  #000000000000000c  // Not so straight extract
// Above: OR bytes 4 (#05) and 6 (#07) into byte 7
// -> #0000000000000007
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER016"
          OCTA  #000000000000000d  // Not so straight extract
// Above: OR bytes 4 (#05) and 5 (#06) and 7 (#08)
// into byte 7
// -> #000000000000000f 
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER017"
          OCTA  #000000000000000e  // Not so straight extract
// Above: OR bytes 4..6 (#05, #06, #07) into byte 7
// -> #0000000000000007
          OCTA  0 // Result
          OCTA  0 // Result

          BYTE  "EXPER018"
          OCTA  #000000000000000f  // Not so straight extract
// Above: OR bytes 4..7 (#05, #06, #07, #08 )
// into byte 7
// -> 000000000000000f
          OCTA  0 // Result
          OCTA  0 // Result
FDATTNENT IS    ((@-FIDDLEDAT)/8)/4 // Experiment count

// DSECT (Table Entry Data Map)
FDEYEC    IS    0
FDDATA    IS    FDEYEC+8
FDRESMOR  IS    FDDATA+8
FDRESMXOR IS    FDRESMOR+8
FDEXPLN   IS    FDRESMXOR+8
//
          GREG  @
CLMPDATA0 OCTA  #000000000001aa5d  # Data
CMPLDMSK  OCTA  #0000000000000003  # Not so straight extract
          BYTE  "BCMPREGS"
BCMPR4    OCTA  0
BCMPR5    OCTA  0

DMEMLEN   IS    @-SEQBYTEM
9H        IS    @

// Code
          LOC   8B
Main      IS    @
          PUSHJ $0,NZZDISP         // Non-zero Z field code
          PUSHJ $0,BCOPYDISP       // Byte Copy Only
          PUSHJ $0,LOW2BDISP       // 2-byte merge
          PUSHJ $0,MRGBBDISP       // Multi byte merge
          PUSHJ $0,MCMPBDISP       // More complex data
//
          LDA    $1,SEQBYTEM       // Parms address (subr $0)
          SET    $2,DMEMLEN         // Length of dump area
          PUSHJ  $0,SHMEMORY        // Call subroutine
//
          TRAP  0,Halt,0           // Exit

// The immediate form MOR $X,$Y,Z always sets the leading seven
// bytes of register X to zero; the other byte is set to the
// bitwise or of whatever bytes of register Y are specified by
// the immediate operand Z.)
NZZDISP   IS    @
          LDOU  $2,SEQBYTEM
          MOR   $3,$2,#01          // -> #08
          STOU  $3,NNZREG3         // Save for dump
          MOR   $4,$2,#03          // -> #0f (#07 | #08)
          STOU  $4,NNZREG4         // Save for dump
          MOR   $5,$2,#ff          // -> #0f (#01 | ... | #08)
          STOU  $5,NNZREG3         // Save for dump
          MOR   $6,$2,#fe          // -> #07 (#01 | ... | #07)
          STOU  $6,NNZREG6         // Save for dump
          POP   0,0

BCOPYDISP IS    @
# -----------------------------------
          LDOU   $1,BYTECOPYM   // Byte copy mask
          LDOU   $2,BYTEMTEST   // Test Pattern
          MOR    $3,$2,$1       // MOR: -> #01020304050607f8
          STOU   $3,BCOPYR3     // Save for dump
          MXOR   $4,$2,$1       // MXOR (Also) -> #01020304050607f8
          STOU   $4,BCOPYR4     // Save for dump
          POP   0,0

LOW2BDISP IS    @
          LDOU  $1,BYTE2LOWM   // Byte copy mask ($Z)
          LDOU  $2,BYTECOPYM   // Test Pattern from old mask ($Y)
          MOR   $3,$2,$1       // MOR -> #8040201008040202
          STOU  $3,BLOWR3      // Save for dump
          MXOR  $4,$2,$1       // MXOR (Also) -> #8040201008040202
          STOU  $4,BLOWR4      // Save for dump
          POP   0,0

MRGBBDISP IS    @
          SETL  $0,FDATTNENT    // Counter
          LDA   $1,FIDDLEDAT    // Table address
          LDOU  $3,SEQNDATA     // Test data ($Y) (Constant this test)
0H        LDOU  $2,$1,FDDATA    // Next Mask ($Z)
          MOR   $4,$3,$2        // MOR
          STOU  $4,$1,FDRESMOR  // Save result for dump
          MXOR  $5,$3,$2        // MXOR (S/B Same)
          STOU  $5,$1,FDRESMXOR // Save result for dump
//
          ADDU  $1,$1,FDEXPLN   // Incr mask address
          SUBU  $0,$0,1         // Decrement experiment count
          PBP   $0,0B           // Loop for all entries
          POP   0,0

MCMPBDISP IS    @
          LDOU  $3,CLMPDATA0    // Data ($Y)
          LDOU  $2,CMPLDMSK     // Mask ($Z)
          MOR   $4,$3,$2        // MOR (-> #ff)
          STOU  $4,BCMPR4       // Save for dump
          MXOR  $5,$3,$2        // MXOR (-> #00)
          STOU  $5,BCMPR5       // Save for dump
          POP   0,0
8H        IS    @

