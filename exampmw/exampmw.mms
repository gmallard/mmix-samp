# Example from Fascicle 1
#
# Slightly enhanced with some additional printed output.
#
# 1) Assemble and link
# 2) Run with: mmix -fdata.txt exampmw.mmo
#

         LOC   Data_Segment
X0       IS    @
######## N        IS    100
N        IS    3        # Changed n from the example
x0       GREG  X0

# Program M Start
j        IS    $0       # j
m        IS    $1       # m
kk       IS    $2       # 8k
xk       IS    $3       # X[k]
t        IS    $255     # temp storage
         LOC   #100
Maximum  SL    kk,$0,3  # M1: Initialize.  k<-n, j<-n
         LDO   m,x0,kk  # m<-X[n]
         JMP   DecrK    # To M2 with k<- n - 1
Loop     LDO   xk,x0,kk # M3: Compare
         CMP   t,xk,m   # t <- [X[k] > m] - [X[k] < m]
         PBNP  t,DecrK  # To M5 if X[k] <= m
ChangeM  SET   m,xk     # M4: m<-X[k]
         SR    j,kk,3   # j<-k
DecrK    SUB   kk,kk,8  # k<-k-1
         PBP   kk,Loop  # M2: To M3 if kk > 0
         POP   2,0      # Return to Main
# Program M end

Main     GETA  t,Start
         TRAP  0,Fputs,StdOut
#
         GETA  t,9F     # Data Address
         TRAP  0,Fread,StdIn  # Read data
#
         GETA  t,Rdone
         TRAP  0,Fputs,StdOut
         SET   $0,N<<3
1H       SR    $2,$0,3  
         PUSHJ $1,Maximum
         LDO   $3,x0,$0
         SL    $2,$2,3
         STO   $1,x0,$0
         STO   $3,x0,$2
         SUB   $0,$0,1<<3
         PBNZ  $0,1B
         GETA  t,9F
         TRAP  0,Fwrite,StdOut
#
         GETA  t,Pdone
         TRAP  0,Fputs,StdOut
         TRAP  0,Halt,0
9H       OCTA  X0+1<<3,N<<3
#
Start    BYTE  "Starting",#a,0
         LOC   4*((@+3)/4)
Rdone    BYTE  "Data Read Done",#a,0
         LOC   4*((@+3)/4)
Pdone    BYTE  #a,"Program Done",#a,0

