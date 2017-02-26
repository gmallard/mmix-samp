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
StrB      IS    @
          BYTE  "1234567890"
StrBLen   IS    @-String            // Bytes
          BYTE  #42 // Eye catcher
          LOC   8*((@+7)/8)         // OCTA Align
StrBParm  OCTA  StrB                // Address
          OCTA  StrBLen             // Length
          OCTA  #20                 // Value
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
//

