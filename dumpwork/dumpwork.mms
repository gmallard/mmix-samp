         LOC   Data_Segment
         GREG  @                   // Base Register
DATA1    BYTE  "12Jk"              // 4 data bytes
ZEROFMSK OCTA  #000000000f0f0f0f   // Low Nybbles Mask
IEXTRMSK OCTA  #0008000400020001   // Initial Extract Mask
//
         LOC   #100
Main     LOC   @
//
         LDTU  $2,DATA1            // Load 4 bytes of data
         PUSHJ $1,GetNybs          // Call Get Nybble Sub
         // Result register is now $1 (Check)
//
         GETA  $255,String         // Point to String
         TRAP  0,Fputs,StdOut      // Write it
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

String   BYTE  "Hello, World!!!!",#a,0





