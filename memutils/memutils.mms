// Memory Related Utilities

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
Blank     OCTA  #20
String    IS    @
          BYTE  "1234567890"
StringLen IS    @-String            // Bytes
          BYTE  #42 // Eye catcher
//
          LOC   8*((@+7)/8)         // OCTA Align
String2   IS    @
          BYTE  "12345678"
          BYTE  "12345678"
          BYTE  "12345678"
          BYTE  "12345678"
String2Ln IS    (@-String2)/8       // OCTAs
          BYTE  #42
//
          LOC   8*((@+7)/8)         // OCTA Align
String3   IS    @
          BYTE  "98765432"
          BYTE  "98765432"
String3Ln IS    (@-String3)         // Bytes
          BYTE  #42
//
          LOC   8*((@+7)/8)         // OCTA Align
ToHere    IS    @
          OCTA  #0101010101010101
          OCTA  #0101010101010101
          OCTA  #0101010101010101
          OCTA  #0101010101010101
          BYTE  #42 // Eye catcher
//
          LOC   8*((@+7)/8)         // OCTA Align
String4   IS    @
          BYTE  "13572468"
          BYTE  "13572468"
          BYTE  "13572468"
          BYTE  "13572468"
String4Ln IS    (@-String4)/8       // OCTAs
          BYTE  #42
//
          LOC   8*((@+7)/8)         // OCTA Align
ToHere2   IS    @
          OCTA  #0202020202020202
          OCTA  #0202020202020202
          OCTA  #0202020202020202
          OCTA  #0202020202020202
          BYTE  #42 // Eye catcher
9H        IS    @
// Code
          LOC   8B
Main      IS    @
//
          LDA   $8,String           // Address
          SETL  $9,StringLen        // Length
          LDOU  $10,Blank           // Set Value
          PUSHJ $7,MemSet           // Call Set
//
          LDA   $8,String           // Address
          SETL  $9,StringLen        // Length
          SETL  $10,#ff             // Set Value
          PUSHJ $7,MemSet           // Call Set
//
          LDA   $8,String2          // Address
          SETL  $9,String2Ln        // OCTA Count
          SETL  $10,#2020           // Set Value
          SETL  $10,#2020           // Set Value
          ORML  $10,#2020           // Set Value
          ORMH  $10,#2020           // Set Value
          ORH   $10,#2020           // Set Value
          PUSHJ $7,MemSetOct        // Call Set
//
          LDA   $8,ToHere           // To address
          LDA   $9,String3          // From Address
          SETL  $10,String3Ln       // Byte Count
          PUSHJ $7,MemCpy           // Call copy
//
          LDA   $8,ToHere2          // To address
          LDA   $9,String4          // From Address
          SETL  $10,String4Ln       // OCTA Count
          PUSHJ $7,MemCpyOct        // Call copy
//
          TRAP  0,Halt,0            // Exit
8H        IS    @
// -------------------------------------------------------------------
          LOC   8B
MemSet    IS    @
// Set memory to a given value.  A crude byte-by-byte implementation.
//
// $0 => Start Address
// $1 => Length (byte count)
// $2 => Replacement Byte
0H        STBU  $2,$0,0           // Set byte to value
          ADDU  $0,$0,1           // Increment Output Addr
          SUBU  $1,$1,1           // Decrement count
          PBP   $1,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @

// -------------------------------------------------------------------
          LOC   8B
MemSetWyd IS    @
// Set memory WYDE's to a given value.
//
// $0 => Start Address (WYDE ALigned)
// $1 => Length (in WYDEs)
// $2 => Replacement Value (All 2 bytes)
0H        STWU  $2,$0,0           // Set WYDE to value
          ADDU  $0,$0,2           // Increment Output Addr
          SUBU  $1,$1,1           // Decrement count
          PBP   $1,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @

// -------------------------------------------------------------------
          LOC   8B
MemSetTet IS    @
// Set memory TETRA's to a given value.
//
// $0 => Start Address (TETRA ALigned)
// $1 => Length (in TETRAs)
// $2 => Replacement Value (All 4 bytes)
0H        STTU  $2,$0,0           // Set TETRA to value
          ADDU  $0,$0,4           // Increment Output Addr
          SUBU  $1,$1,1           // Decrement count
          PBP   $1,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @
// -------------------------------------------------------------------
          LOC   8B
MemSetOct IS    @
// Set memory OCTA's to a given value.
//
// $0 => Start Address (OCTA ALigned)
// $1 => Length (in OCTAs)
// $2 => Replacement Value (All 8 bytes)
0H        STOU  $2,$0,0           // Set OCTA to value
          ADDU  $0,$0,8           // Increment Output Addr
          SUBU  $1,$1,1           // Decrement count
          PBP   $1,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @

// -------------------------------------------------------------------
          LOC   8B
MemCpy    IS    @
// Copy memory, byte-by-byte.
//
// $0 => To Address
// $1 => From Address
// $2 => Length (byte count)
0H        LDBU  $3,$1,0           // Get From Byte
          STBU  $3,$0,0           // Store it
          ADDU  $0,$0,1           // Increment To Addr
          ADDU  $1,$1,1           // Increment From Addr
//
          SUBU  $2,$2,1           // Decrement byte count
          PBP   $2,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @

// -------------------------------------------------------------------
          LOC   8B
MemCpyWyd IS    @
// Copy memory, WYDE-by-WYDE
//
// $0 => To Address (WYDE aligned)
// $1 => From Address (WYDE aligned)
// $2 => Length (WYDE count)
//
// Programming Note:  If the to and/or from address is _not_ WYDE
// aligned, this routine will silently corrupt some part of the 
// caller's memory space.  Let the caller beware!
0H        LDWU  $3,$1,0           // Get From WYDE
          STWU  $3,$0,0           // Store it
          ADDU  $0,$0,2           // Increment To Addr
          ADDU  $1,$1,2           // Increment From Addr
//
          SUBU  $2,$2,1           // Decrement WYDE count
          PBP   $2,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @

// -------------------------------------------------------------------
          LOC   8B
MemCpyTet IS    @
// Copy memory, TETRA-by-TETRA
//
// $0 => To Address (TETRA aligned)
// $1 => From Address (TETRA aligned)
// $2 => Length (TETRA count)
//
// Programming Note:  If the to and/or from address is _not_ TETRA
// aligned, this routine will silently corrupt some part of the 
// caller's memory space.  Let the caller beware!
0H        LDTU  $3,$1,0           // Get From TETRA
          STTU  $3,$0,0           // Store it
          ADDU  $0,$0,4           // Increment To Addr
          ADDU  $1,$1,4           // Increment From Addr
//
          SUBU  $2,$2,1           // Decrement TETRA count
          PBP   $2,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @
// -------------------------------------------------------------------
          LOC   8B
MemCpyOct IS    @
// Copy memory, OCTA-by-OCTA
//
// $0 => To Address (OCTA aligned)
// $1 => From Address (OCTA aligned)
// $2 => Length (OCTA count)
//
// Programming Note:  If the to and/or from address is _not_ OCTA
// aligned, this routine will silently corrupt some part of the 
// caller's memory space.  Let the caller beware!
0H        LDOU  $3,$1,0           // Get From OCTA
          STOU  $3,$0,0           // Store it
          ADDU  $0,$0,8           // Increment To Addr
          ADDU  $1,$1,8           // Increment From Addr
//
          SUBU  $2,$2,1           // Decrement OCTA count
          PBP   $2,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @

