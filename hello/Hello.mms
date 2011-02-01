argv     IS    $1                  Argv vector ?
         LOC   #100
Main     LDOU  $255,argv,0         Address of program name
         TRAP  0,Fputs,StdOut      Write it
         GETA  $255,String         Point toString
         TRAP  0,Fputs,StdOut      Write it
         TRAP  0,Halt,0            Exit
String   BYTE  ",world",#a,0       String with newline and terminator

