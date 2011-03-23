// Sample pattern for new programs

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
String    BYTE  ", says hello",#a,0 // String, newline, terminator
9H        IS    @
// Code
          LOC   8B
argv      IS    $1                  // Parm register
Main      LDOU  $255,argv,0         // Address of program name
          TRAP  0,Fputs,StdOut      // Write it
          LDA   $255,String         // Point to String
          TRAP  0,Fputs,StdOut      // Write it
          TRAP  0,Halt,0            // Exit
8H        IS    @

