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
// Code
         LOC    8B
Main     IS     @

//--------------------------------------------------------------------
//------- Set Memory Tests -------------------------------------------
//--------------------------------------------------------------------
//****
//       Set Bytes
         LDA    $8,SBParms          // Parms address
         GETA   $4,MemSetByt        // Call Set Bytes
         PUSHGO $7,$4,0             // Call Set Bytes
//****   
//       Set Wydes
         LDA    $8,SWParms          // Parms address
         GETA   $4,MemSetWyd        // Call Set Wydes
         PUSHGO $7,$4,0             // Call Set Wydes
//****         
//       Set Tetras
         LDA    $8,STParms          // Parms address
         GETA   $4,MemSetTet        // Call Set Tetras
         PUSHGO $7,$4,0             // Call Set Tetras
//****         
//       Set Octas
         LDA    $8,SOParms          // Parms address
         GETA   $4,MemSetOct        // Call Set Octas
         PUSHGO $7,$4,0             // Call Set Octas
//****         

//--------------------------------------------------------------------
//------- Copy Memory Tests ------------------------------------------
//--------------------------------------------------------------------
//****
//       Copy Bytes
         LDA    $8,CFBParms         // Parms address
         GETA   $4,MemCpyByt        // Call Copy Bytes
         PUSHGO $7,$4,0             // Call Copy Bytes
//****
//       Copy Wydes
         LDA    $8,CFWParms         // Parms address
         GETA   $4,MemCpyWyd        // Call Copy Wydes
         PUSHGO $7,$4,0             // Call Copy Wydes
//****
//       Copy Tetras
         LDA    $8,CFTParms         // Parms address
         GETA   $4,MemCpyTet        // Call Copy Tetras
         PUSHGO $7,$4,0             // Call Copy Tetras
//****
//       Copy Octas
         LDA    $8,CFOParms         // Parms address
         GETA   $4,MemCpyOct        // Call Copy Octas
         PUSHGO $7,$4,0             // Call Copy Octas

// Retrun to OS
         TRAP   0,Halt,0          // Exit
8H       IS     @
//

