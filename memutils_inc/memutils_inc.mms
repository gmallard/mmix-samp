// Demo Memory Related Utilities

// Start Data Segment
         LOC    Data_Segment
// Base     GREG  9B               // Base Register
         GREG   @                   // Base Register
9H       IS     @

// Start Code/Text Segment
         LOC    #100
8H       IS     @

// -------------------------------------------------------------------
// Data
         LOC    9B
// Data for Set Bytes
ToByteDA BYTE   #bb,#bb,#bb,#bb,#bb,#bb,#bb,#bb
         BYTE   #bb,#bb,#bb,#bb,#bb,#bb,#bb,#bb
         BYTE   #bb,#bb,#bb,#bb,#bb,#bb,#bb,#bb
         BYTE   #bb,#bb,#bb,#bb,#bb
ToByteDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
// Set parms
SBParms  OCTA   ToByteDA
         OCTA   (ToByteDE-ToByteDA)/1 // Byte Count
         OCTA   #11         

// Data for Set Wydes
ToWydeDA WYDE   #dddd,#dddd,#dddd,#dddd,#dddd
ToWydeDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
// Set parms
SWParms  OCTA   ToWydeDA
         OCTA   (ToWydeDE-ToWydeDA)/2 // Wyde Count
         OCTA   #2222

// Data for Set Tetras
ToTetrDA TETRA  #eeeeeeee,#eeeeeeee,#eeeeeeee,#eeeeeeee
ToTetrDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
// Set parms
STParms  OCTA   ToTetrDA
         OCTA   (ToTetrDE-ToTetrDA)/4 // Tetra Count
         OCTA   #33333333

// Data for Set Octas
ToOctaDA OCTA   #ffffffffffffffff,#ffffffffffffffff
         OCTA   #ffffffffffffffff,#ffffffffffffffff
         OCTA   #ffffffffffffffff,#ffffffffffffffff
         OCTA   #ffffffffffffffff
ToOctaDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
// Set parms
SOParms  OCTA   ToOctaDA
         OCTA   (ToOctaDE-ToOctaDA)/8 // Octa Count
         OCTA   #4444444444444444

// -------------------------------------------------------------------
// Code
         LOC    8B
Main     IS     @
//****
//       Set Bytes
         LDA    $8,SBParms          // Parms address
         PUSHJ  $7,MemSetByt        // Call Set Bytes
//****   
//       Set Wydes
         LDA    $8,SWParms          // Parms address
         PUSHJ  $7,MemSetWyd        // Call Set Wydes
//****         
//       Set Tetras
         LDA    $8,STParms          // Parms address
         PUSHJ  $7,MemSetTet        // Call Set Tetras
//****         
//       Set Octas
         LDA    $8,SOParms          // Parms address
         PUSHJ  $7,MemSetOct        // Call Set Octas
//****         
// Retrun to OS
         TRAP   0,Halt,0          // Exit
8H       IS     @
//

