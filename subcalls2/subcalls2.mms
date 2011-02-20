//
// More elaborate demonstration of a simple style of 
// subroutine linkage.  
//
// - Use a register other than $0
// - Show that this style does _not_ renumber registers in the 
// subroutine
// - Changes made to registers are visible by the calling
// routine after return
// - Check status of _everything_ using 'mmix -i'
//
         LOC   #100
Main     LOC   @
         GETA  $255,Starting       // Address of start message
         TRAP  0,Fputs,StdOut      // Write it
//
         GETA  $0,SendM1A          // Sub Addr
         GO    $0,$0,0             // Call it
//
  			 SETL   $0,0							 // Set constant
  			 SETL   $1,1							 // Set constant
  			 SETL   $2,2							 // Set constant
  			 SETL   $3,3							 // Set constant
  			 SETL   $4,4							 // Set constant
//       Observe registers $0...$4 here using : mmix -i subcalls2.mmo
         GETA  $5,SendM2A          // Sub Addr
         GO    $5,$5,0						 // Call it
//
         GETA  $255,Ending         // Address of end message
				 TRAP  0,Fputs,StdOut      // Write it
         TRAP  0,Halt,0            // Exit
//
SendM1A  GETA  $255,Sub1Msg        // Message Address
         TRAP  0,Fputs,StdOut      // Write it
         GO    $0,$0,0             // Return
//
SendM2A  LOC   @
				 NOR	 $0,$0,0						 // Change reg $0
				 NOR	 $1,$1,0						 // Change reg $1
				 NOR	 $2,$2,0						 // Change reg $2
				 NOR	 $3,$3,0						 // Change reg $3
				 NOR	 $4,$4,0						 // Change reg $4
//       Observe registers $0...$4 here using : mmix -i subcalls2.mmo
			   GETA  $255,Sub2Msg        // Message Address
         TRAP  0,Fputs,StdOut      // Write it
         GO    $5,$5,0             // Return
//
Starting BYTE  "Starting ....",#a,0
//
         LOC   4*((@+3)/4)         // TETRA Align
Ending   BYTE  "Ending ....",#a,0
//
         LOC   4*((@+3)/4)         // TETRA Align
Sub1Msg  BYTE  "Message from routine one",#a,0
//
         LOC   4*((@+3)/4)         // TETRA Align
Sub2Msg  BYTE  "Message from routine two",#a,0
//

