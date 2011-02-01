#
# Demonstrate how to get diagnostic information.
#
# After assemble and link run with one of:
#
# mmix -r abend.mmo
#
# mmix -v abend.mmo
#
# mmix -I abend.mmo
#
         LOC   #100
Main     GETA  $255,String         Address of message
         TRAP  0,Fputs,StdOut      Write it
#
         GETA  $1,Oct01            Data Address
         LDOU  $3,$1,0             Actual Data
         GETA  $2,Oct02            Data Address
         LDOU  $4,$2,0             Actual Data
#
         TETRA #08080808           Bad instruction
         TRAP  0,Halt,0            Exit
String   BYTE  "Abend Demonstation??",#a,0
Oct01    OCTA  #01010101010101010101010101010101
Oct02    OCTA  #02020202020202020202020202020202

