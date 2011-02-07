         LOC   Data_Segment
         GREG  @                   // Base Register
         LOC   8*((@+7)/8)         // OCTA ALign
DATA1    BYTE  #01,#89,#ab,#ef     // 4 data bytes
         BYTE  #23,#6a,#f4,#ff     // 4 mote data bytes
ZEROFMSK OCTA  #000000000f0f0f0f   // Low Nybbles Mask
IEXTRMSK OCTA  #0008000400020001   // Initial Extract Mask
INYBMSK  OCTA  #0000000000000080   // Initial Nybble Mask
//
HEXTRTAB BYTE  "0123456789"        // XLATE Table - 1
ALPHATAB BYTE  "abcdef"            // XLATE Table - 2
//
         LOC   8*((@+7)/8)         // OCTA ALign
PRTBUFF  BYTE  "........"          // 8 bytes
         BYTE  "........"          // 8 bytes
         BYTE  #a,#0               // Valid Line End
// -------------------------------------------------------------------
         LOC   #100
Main     LOC   @
//
         LDA   $2,DATA1            // In data Start Address
         LDA   $3,PRTBUFF          // Output data start address
         SETL  $4,1                // Number of OCTA's
         PUSHJ $1,FmtOctas         // Go Print them
         LDA   $255,PRTBUFF        // Point to String
         TRAP  0,Fputs,StdOut      // Write it
//
         TRAP  0,Halt,0            // Exit
// -------------------------------------------------------------------
FmtOctas LOC   @
// $0 => Input Start Address
// $1 => Output Start Address
// $2 => Octa Count
         GET   $3,rJ               // Get Return Address
         SLU   $2,$2,1             // Get TETRA Count
1H       LDTU  $5,$0               // Load Next TETRA data
         PUSHJ $4,GetNybs          // Call Get Nybbles Sub
         ADDU  $5,$4,0             // Set Nybbles Parm
         PUSHJ $4,GetBytes         // Call Get Bytes Sub
//
         STOU  $4,$1               // Store Output
         ADD   $0,$0,4             // Next TETRA Input
         ADD   $1,$1,8             // Next OCTA Output
         SUBU  $2,$2,1             // Decrement TETRA Count
         PBP   $2,1B               // Loop for all TETRAS
//
         PUT   rJ,$3               // Set Return Address
         POP   0,0                 // Return Nothing
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
//
         SLU   $6,$6,8             // Shift extraction mask
         MOR   $4,$2,$6            // Extract to correct byte positions
//
         OR    $0,$3,$4            // Or them together
         POP   1,0                 // Return 1 result register

// -------------------------------------------------------------------
GetBytes LOC   @
         SETL  $2,8                // Loop Count
         LDOU  $3,INYBMSK          // Get Nybble/Byte extract mask
//
         LDA   $7,HEXTRTAB         // Translate table
1H       LOC   @
         SLU   $6,$6,8             // Room for next byte
         MOR   $4,$0,$3            // Extract next byte
         LDBU  $4,$7,$4            // XLATE the byte
//
         OR    $6,$6,$4            // OR into working result
         SRU   $3,$3,1             // Crank next extract mask
         SUBU  $2,$2,1             // Decrement
         PBP   $2,1B               // Loop
//
         ADDU  $0,$6,0             // Copy working result
         POP   1,0                 // Return 1 result register

