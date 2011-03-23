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
StringLen IS    @-String
          BYTE  #42
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
          TRAP  0,Halt,0            // Exit
8H        IS    @
// -------------------------------------------------------------------
          LOC   8B
MemSet    IS    @
// Set mmemory to a given value.  A crude byte-by-byte implementation.
//
// $0 => Start Address
// $1 => Length
// $2 => Replacement Byte
0H        STBU  $2,$0,0           // Set byte to value
          ADDU  $0,$0,1           // Increment Output Addr
          SUBU  $1,$1,1           // Decrement count
          PBP   $1,0B             // Loop for all
          POP   0,0               // Return
8H        IS    @

