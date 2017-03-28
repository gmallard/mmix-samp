         LOC   8B
argv     IS    $1                  // Argv vector ?
Main     LDOU  $255,argv,0         // Address of program name
         TRAP  0,Fputs,StdOut      // Write it
         GETA  $255,String         // Point to String
         TRAP  0,Fputs,StdOut      // Write it
// Print a blank line
         PUSHJ $0,BlankLine        // Print A Blank line
         TRAP  0,Halt,0            // Exit
String   BYTE  ", world",#a,0      // String, newline and terminator
8H       IS    @
