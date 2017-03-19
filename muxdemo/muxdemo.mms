//*BEGIN muxdemo.mms
// Data
          LOC   9B
// TOE: Table of experiments
MuxData   LOC   @+(8-@)&7            // OCTA Align
          OCTA  #0000000000000000    // Y reg
          OCTA  #0000000000000000    // Z reg
          OCTA  #0000000000000000    // rM reg
MuxDataL  IS    @-MuxData            // Experiment Length
// Start 2nd experiment ....
          OCTA  #0000000000000000    // Y reg
          OCTA  #0000000000000000    // Z reg
          OCTA  #ffffffffffffffff    // rM reg
//
          OCTA  #ffffffffffffffff    // Y reg
          OCTA  #0000000000000000    // Z reg
          OCTA  #0000000000000000    // rM reg
//
          OCTA  #ffffffffffffffff    // Y reg
          OCTA  #0000000000000000    // Z reg
          OCTA  #ffffffffffffffff    // rM reg
//
          OCTA  #0000000000000000    // Y reg
          OCTA  #ffffffffffffffff    // Z reg
          OCTA  #0000000000000000    // rM reg
//
          OCTA  #0000000000000000    // Y reg
          OCTA  #ffffffffffffffff    // Z reg
          OCTA  #ffffffffffffffff    // rM reg
//
          OCTA  #0123456789abcdef    // Y reg
          OCTA  #0000000000000000    // Z reg
          OCTA  #0000000000000000    // rM reg
//
          OCTA  #0123456789abcdef    // Y reg
          OCTA  #0000000000000000    // Z reg
          OCTA  #ffffffffffffffff    // rM reg
//
          OCTA  #0123456789abcdef    // Y reg
          OCTA  #ffffffffffffffff    // Z reg
          OCTA  #0000000000000000    // rM reg
//
          OCTA  #0123456789abcdef    // Y reg
          OCTA  #ffffffffffffffff    // Z reg
          OCTA  #ffffffffffffffff    // rM reg
//
// This illustrates fairly well what the docs say:
// "if Mj then Yj else Zj" (j is a bit number)
// Result will be:
//    #192a3b4c5d6e7182
//
          OCTA  #1f2f3f4f5f6f7f8f    // Y reg
          OCTA  #f9fafbfcfdfef1f2    // Z reg
          OCTA  #f0f0f0f0f0f0f0f0    // rM reg
MuxExEnd  IS    @                    // End of TOE
MuxNumEx  IS    (MuxExEnd-MuxData)/MuxDataL // Count
// Table entry 'DSECT'
MuxYReg   IS    0
MuxZReg   IS    8
MuxGrM    IS    16
//
          GREG  @
Foxes     OCTA  #ffffffffffffffff // For XOR
// Display area
MuxDmpEx  IS    @
          BYTE  "Y Register:       #"
MDYReg    BYTE  "................"
          BYTE  #a
          BYTE  "Z Register:       #"
MDZReg    BYTE  "................"
          BYTE  #a
          BYTE  "rM Register:      #"
MDrMReg   BYTE  "................"
          BYTE  #a
          BYTE  "rM Comp Register: #"
MDrMRegC  BYTE  "................"
          BYTE  #a
          BYTE  "X Register:       #"
MDXReg    BYTE  "................"
          BYTE  #a,0
//
9H        IS    @
// Code
          LOC   8B
Main      IS    @
          LDA   $1,MuxData          // Point to start address
          SET   $2,MuxNumEx         // Number of experiments
CallNextE IS    @
          SET   $4,$1               // Copy Address
          PUSHJ $3,NextMuxE         // Call the experiment
//
          ADDU  $1,$1,MuxDataL      // Bump to next experiment
          SUBU  $2,$2,1             // Decr Number of experiments
          PBP   $2,CallNextE        // Loop for all experiments
          TRAP  0,Halt,0            // Exit
//
NextMuxE  IS    @
          GET    $8,rJ               // Return address
//
          SET   $2,$0                // Copy Base Address
//
          LDOU  $17,$2,MuxYReg       // Get MUX Y Register
          LDA   $18,MDYReg           // Output Area
          PUSHJ $16,PUTMEMRD         // Call the output routine
//
          LDOU  $17,$2,MuxZReg       // Get MUX Z Register
          LDA   $18,MDZReg           // Output Area
          PUSHJ $16,PUTMEMRD         // Call the output routine
//
          LDOU  $17,$2,MuxGrM        // Get rM Register
          LDA   $18,MDrMReg          // Output Area
          PUSHJ $16,PUTMEMRD         // Call the output routine
//
          LDOU  $17,$2,MuxGrM        // Get rM Register (again)
          LDOU  $0,Foxes             // Get all 1's
          XOR   $17,$17,$0           // Flip the bits
          ANDN  $17,$17,0            // Get Complement
          LDA   $18,MDrMRegC         // Output Area
          PUSHJ $16,PUTMEMRD         // Call the output routine
// --------------------------------------------------------
//        $X -> $4
//        $Y -> $5
//        $Z -> $6
//        MUX   $X,$Y,$Z
          LDOU  $5,$2,MuxYReg        // Get Y Register
          LDOU  $6,$2,MuxZReg        // Get Z Register
          LDOU  $0,$2,MuxGrM         // Get rM value
          PUT   rM,$0                // Set it
          // Docs Say: if Mj then Yj else Zj
          MUX   $4,$5,$6             // The experiment
// --------------------------------------------------------
          SET   $17,$4               // The result value
          LDA   $18,MDXReg           // Result output area
          PUSHJ $16,PUTMEMRD         // Call the output routine   
// --------------------------------------------------------
          LDA   $255,MuxDmpEx        // Set OS Register
          TRAP  0,Fputs,StdOut       // Write it
          PUSHJ $16,BlankLine        // Print A Blank line
          PUT   rJ,$8                // Set Ret Addr
          POP   0,0
8H        IS    @
//*END muxdemo.mms
