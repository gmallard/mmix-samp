// -------------------------------------------------------------------
// Code
         LOC    8B
Main     IS     @
//****
         LDA    $0,SPREGDAT       // Adress of register addresses
         SETL   $1,SPGREGLN       // Count of addresses
0H       IS     @
         LDOU   $2,$0             // Get Address of Reg Data
         ADDU   $255,$2,5         // Point to text area
         TRAP   0,Fputs,StdOut     // Write it
// Loop end
         ADDU   $0,$0,8           // Point to next pointer
         SUBU   $1,$1,1           // Decrement Reg Data Count
         PBP    $1,0B             // Loop for all regs
// Return to OS
         TRAP   0,Halt,0          // Exit
8H       IS     @
//
