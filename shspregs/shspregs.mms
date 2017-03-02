// -------------------------------------------------------------------
// Code
         LOC    8B
Main     IS     @
osreg    IS     $255
//****
         LDA    $15,SPREGDAT        // Adress of register addresses
         SETL   $14,SPGREGLN        // Count of addresses
0H       IS     @ 
         LDOU   $13,$15             // Get Address of Reg Data
         ADDU   osreg,$13,5         // Point to text area
         TRAP   0,Fputs,StdOut      // Write it
// Loop end
         ADDU   $15,$15,8           // Point to next pointer
         SUBU   $14,$14,1           // Decrement Reg Data Count
         PBP    $14,0B              // Loop for all regs
// Return to OS
         TRAP   0,Halt,0            // Exit
8H       IS     @
//
