// -------------------------------------------------------------------
// Code
         LOC    8B
Main     IS     @

//--------------------------------------------------------------------
//------- Set Memory Tests -------------------------------------------
//--------------------------------------------------------------------
//****
//       Set Bytes
//       Show the Area before set
         PUSHJ  $0,BlankLine        // Write empty line
         LDOU   $8,SBParms          // Start of Dump Area
         LDOU   $9,SBParms+8        // Length of Data
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $7,$4,0             // Call Mem Dump
//       Call the set
         LDA    $8,SBParms          // Parms address
         GETA   $4,MemSetByt        // Call Set Bytes
         PUSHGO $7,$4,0             // Call Set Bytes
//       Show the Area after set
         LDOU   $8,SBParms          // Start of Dump Area
         LDOU   $9,SBParms+8        // Length of Data
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $7,$4,0             // Call Mem Dump

//****   
//       Set Wydes
//       Show the Area before set
         PUSHJ  $0,BlankLine        // Write empty line
         LDOU   $8,SWParms          // Start of Dump Area
         LDOU   $9,SWParms+8        // Length of Data
         SLU    $9,$9,1             // * 2 (byte count)
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $7,$4,0             // Call Mem Dump
//       Call the set
         LDA    $8,SWParms          // Parms address
         GETA   $4,MemSetWyd        // Call Set Wydes
         PUSHGO $7,$4,0             // Call Set Wydes
//       Show the Area after set
         LDOU   $8,SWParms          // Start of Dump Area
         LDOU   $9,SWParms+8        // Length of Data
         SLU    $9,$9,1             // * 2 (byte count)
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $7,$4,0             // Call Mem Dump

//****         
//       Set Tetras
//       Show the Area before set
         PUSHJ  $0,BlankLine        // Write empty line
         LDOU   $8,STParms          // Start of Dump Area
         LDOU   $9,STParms+8        // Length of Data
         SLU    $9,$9,2             // * 4 (byte count)
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $7,$4,0             // Call Mem Dump
//       Call the set
         LDA    $8,STParms          // Parms address
         GETA   $4,MemSetTet        // Call Set Tetras
         PUSHGO $7,$4,0             // Call Set Tetras
//       Show the Area after set
         LDOU   $8,STParms          // Start of Dump Area
         LDOU   $9,STParms+8        // Length of Data
         SLU    $9,$9,2             // * 4 (byte count)
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $7,$4,0             // Call Mem Dump

//****         
//       Set Octas
//       Show the Area before set
         PUSHJ  $0,BlankLine        // Write empty line
         LDOU   $8,SOParms          // Start of Dump Area
         LDOU   $9,SOParms+8        // Length of Data
         SLU    $9,$9,3             // * 8 (byte count)
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $7,$4,0             // Call Mem Dump
//       Call the set
         LDA    $8,SOParms          // Parms address
         GETA   $4,MemSetOct        // Call Set Octas
         PUSHGO $7,$4,0             // Call Set Octas
//       Show the Area after set
         LDOU   $8,SOParms          // Start of Dump Area
         LDOU   $9,SOParms+8        // Length of Data
         SLU    $9,$9,3             // * 8 (byte count)
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $7,$4,0             // Call Mem Dump

//--------------------------------------------------------------------
//------- Copy Memory Tests ------------------------------------------
//--------------------------------------------------------------------
//****
//       Copy Bytes
//       From Data
         PUSHJ  $0,BlankLine        // Write empty line
         LDA    $2,CFBParms         // Parms address
         PUSHJ  $1,GETFROMD         // Get From Data
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump
//       To Data
         LDA    $2,CFBParms         // Parms address
         PUSHJ  $1,GETTOD           // Get To Data
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump
//        
         LDA    $8,CFBParms         // Parms address
         GETA   $4,MemCpyByt        // Call Copy Bytes
         PUSHGO $7,$4,0             // Call Copy Bytes
//       To data again
         LDA    $2,CFBParms         // Parms address
         PUSHJ  $1,GETTOD           // Get To Data
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump

//****
//       From Data
         PUSHJ  $0,BlankLine        // Write empty line
         LDA    $2,CFWParms         // Parms address
         PUSHJ  $1,GETFROMD         // Get From Data
         SLU    $2,$2,1             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump
//       To Data
         LDA    $2,CFWParms         // Parms address
         PUSHJ  $1,GETTOD           // Get To Data
         SLU    $2,$2,1             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump
//       Copy Wydes
         LDA    $8,CFWParms         // Parms address
         GETA   $4,MemCpyWyd        // Call Copy Wydes
         PUSHGO $7,$4,0             // Call Copy Wydes
//       To Data again
         LDA    $2,CFWParms         // Parms address
         PUSHJ  $1,GETTOD           // Get To Data
         SLU    $2,$2,1             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump

//****
//       From Data
         PUSHJ  $0,BlankLine        // Write empty line
         LDA    $2,CFTParms         // Parms address
         PUSHJ  $1,GETFROMD         // Get From Data
         SLU    $2,$2,2             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump
//       To Data
         LDA    $2,CFTParms         // Parms address
         PUSHJ  $1,GETTOD           // Get To Data
         SLU    $2,$2,2             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump
//       Copy Tetras
         LDA    $8,CFTParms         // Parms address
         GETA   $4,MemCpyTet        // Call Copy Tetras
         PUSHGO $7,$4,0             // Call Copy Tetras
//       To Data Again
         LDA    $2,CFTParms         // Parms address
         PUSHJ  $1,GETTOD           // Get To Data
         SLU    $2,$2,2             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump

//****
//       From Data
         PUSHJ  $0,BlankLine        // Write empty line
         LDA    $2,CFOParms         // Parms address
         PUSHJ  $1,GETFROMD         // Get From Data
         SLU    $2,$2,3             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump
//       To Data
         LDA    $2,CFOParms         // Parms address
         PUSHJ  $1,GETTOD           // Get To Data
         SLU    $2,$2,3             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump
//       Copy Octas
         LDA    $8,CFOParms         // Parms address
         GETA   $4,MemCpyOct        // Call Copy Octas
         PUSHGO $7,$4,0             // Call Copy Octas
//       To Data
         LDA    $2,CFOParms         // Parms address
         PUSHJ  $1,GETTOD           // Get To Data
         SLU    $2,$2,3             // Get byte count
         GETA   $4,SHMEMORY         // Subr address
         PUSHGO $0,$4,0             // Call Mem Dump

// Retrun to OS
         TRAP   0,Halt,0          // Exit

//--------------------------------------------------------------------
GETFROMD  IS     @
          GET    $8,rJ              // Return address
          LDOU   $1,$0,0            // From Address
          LDOU   $0,$0,16           // Length
          PUT    rJ,$8              // Set Ret Addr
          POP    2,0                // Return (two regs)
//--------------------------------------------------------------------
GETTOD    IS     @
          GET    $8,rJ              // Return address
          LDOU   $1,$0,8            // Get the to address
          LDOU   $0,$0,16           // Get the length
          PUT    rJ,$8              // Set Ret Addr
          POP    2,0                // Return (two regs)
//--------------------------------------------------------------------
BlankLine IS     @
          GET    $8,rJ              // Return address
          GETA   $255,BlankData     // Empty Line
          TRAP   0,Fputs,StdOut     // Write it
          PUT    rJ,$8              // Set Ret Addr
          POP    0,0                // Return (no data)
BlankData BYTE  " ",#a,0
8H        IS     @
//
