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
// Set Memory data
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

// Copy Memory data
// Data for Copy Bytes
CTByteDA BYTE   #bb,#bb,#bb,#bb,#bb,#bb,#bb,#bb
CTByteDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
CFByteDA BYTE   #11,#11,#11,#11,#11,#11,#11,#11
CFByteDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
         
         GREG   @                  // New Base Register         
CFBParms OCTA   CFByteDA           // From Address
         OCTA   CTByteDA           // To Address
         OCTA   (CTByteDE-CTByteDA)/1   // Length (bytes)
// Data for Copy Wydes
CTWydeDA WYDE   #cccc,#cccc,#cccc,#cccc,#cccc
CTWydeDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
CFWydeDA WYDE   #2222,#2222,#2222,#2222,#2222
CFWParms OCTA   CFWydeDA           // From Address
         OCTA   CTWydeDA           // To Address
         OCTA   (CTWydeDE-CTWydeDA)/2   // Length (wydes)
// Data for Copy Tetras
CTTetrDA TETRA  #dddddddd,#dddddddd,#dddddddd
CTTetrDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
CFTetrDA TETRA  #33333333,#33333333,#33333333
CFTParms OCTA   CFTetrDA           // From Address
         OCTA   CTTetrDA           // To Address
         OCTA   (CTTetrDE-CTTetrDA)/4   // Length (tetras)
// Data for Copy Octas
CTOctaDA OCTA   #eeeeeeeeeeeeeeee,#eeeeeeeeeeeeeeee,#eeeeeeeeeeeeeeee
CTOctaDE IS     @
         LOC    @+(8-@)&7 // OCTA Align
         BYTE   "Z","Z","Z","Z","Z","Z","Z","Z" // Eye catcher (0x5a)
CFOctaDA OCTA   #4444444444444444,#4444444444444444,#4444444444444444
CFOParms OCTA   CFOctaDA           // From Address
         OCTA   CTOctaDA           // To Address
         OCTA   (CTOctaDE-CTOctaDA)/8   // Length (tetras)

// -------------------------------------------------------------------
// Code
         LOC    8B
Main     IS     @

//--------------------------------------------------------------------
//------- Set Memory Tests -------------------------------------------
//--------------------------------------------------------------------
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

//--------------------------------------------------------------------
//------- Copy Memory Tests ------------------------------------------
//--------------------------------------------------------------------
//****
//       Copy Bytes
         LDA    $8,CFBParms         // Parms address
         PUSHJ  $7,MemCpyByt        // Call Copy Bytes
//****
//       Copy Wydes
         LDA    $8,CFWParms         // Parms address
         PUSHJ  $7,MemCpyWyd        // Call Copy Wydes
//****
//       Copy Tetras
         LDA    $8,CFTParms         // Parms address
         PUSHJ  $7,MemCpyTet        // Call Copy Tetras
//****
//       Copy Octas
         LDA    $8,CFOParms         // Parms address
         PUSHJ  $7,MemCpyOct        // Call Copy Octas

// Retrun to OS
         TRAP   0,Halt,0          // Exit
8H       IS     @
//

