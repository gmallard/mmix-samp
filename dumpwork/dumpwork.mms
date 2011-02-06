         LOC   Data_Segment
         GREG  @                   // Base Register
// DATA1    BYTE  "12Jk"              // 4 data bytes
DATA1    BYTE  #01,#89,#ab,#ef     // 4 data bytes
ZEROFMSK OCTA  #000000000f0f0f0f   // Low Nybbles Mask
IEXTRMSK OCTA  #0008000400020001   // Initial Extract Mask
INYBMSK  OCTA  #0000000000000080   // Initial Nybble Mask
ALPHATAB BYTE  "ABCDEF"            // XLATE Table
//
         LOC   8*((@+7)/8)         // OCTA ALign
PRTBUFF  BYTE  "........"          // 8 bytes
         BYTE  #a,#0               // Valid Line End
//
         LOC   #100
Main     LOC   @
//
         LDTU  $2,DATA1            // Load 4 bytes of data
         PUSHJ $1,GetNybs          // Call Get Nybbles Sub
// Result register is now $1 (Check)
         ADDU  $2,$1,0             // Copy Nybbles
         PUSHJ $1,GetBytes         // Call Get Bytes Sub
         STOU  $1,PRTBUFF          // Set result for print
//
         GETA  $255,String         // Point to String
         TRAP  0,Fputs,StdOut      // Write it
//
         LDA   $255,PRTBUFF        // Point to String
         TRAP  0,Fputs,StdOut      // Write it
//
         TRAP  0,Halt,0            // Exit
// -------------------------------------------------------------------
GetNybs  LOC   @
//
         LDOU  $5,ZEROFMSK         // Load Mask for Low Nybbles
         LDOU  $6,IEXTRMSK         // Load Initial Mask for Extraction
//
         ADDU  $1,$0,0             // Copy Input
         AND   $2,$1,$5            // Get Low Nybbles
         MOR   $3,$2,$6            // Extract to correct byte positions
//
         ADDU  $1,$0,0             // Copy Input Again
         SRU   $1,$1,4             // Shift the nybbles
         AND   $2,$1,$5            // Get Low Nybbles
         SLU   $6,$6,8             // Shift extraction mask
         MOR   $4,$2,$6            // Extract to correct byte positions
//
         OR    $0,$3,$4            // Or them together
         POP   1,0                 // Return 1 result register

// -------------------------------------------------------------------
GetBytes LOC   @
         SETL  $2,8                // Loop Count
         LDOU  $3,INYBMSK          // Get Nybble/Byte extract mask
         LDA   $7,ALPHATAB         // Address of XLATE Table
#
1H       LOC   @
         SLU   $6,$6,8             // Room for next byte
         MOR   $4,$0,$3            // Extract next byte
         SUBU  $5,$4,10            // Byte - 10
         PBN   $5,2F               // Go processs 0-9

#        Process A-F
         OR    $4,$4,#f0           // Temp for now
         LDBU  $4,$7,$5            // XLATE this value
         JMP   9F                  // Merge for next byte

#        Process 0-9
2H       LOC   @
         OR    $4,$4,#30           // OR in character mask
#        Fall through

9H       LOC   @
         OR    $6,$6,$4            // OR into working result
         SRU   $3,$3,1             // Crank next extract mask
         SUBU  $2,$2,1             // Decrement
         PBP   $2,1B               // Loop
#
         ADDU  $1,$6,0             // Copy working result
         POP   2,0                 // Return 2 result registers

String   BYTE  "Hello, World!!!!",#a,0
         LOC   4*((@+3)/4)         // ALign
SubMsg   BYTE  "In Sub",#a,0




