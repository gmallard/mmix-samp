//*BEGIN bddemo.mms
// Examples of BDIF, from the docs.
// Start Data Segment
          LOC   9B                  // Data start
          GREG  @                   // Base Register
AVALUE    OCTA  #0102030405060708
BVALUE    OCTA  #0301040205030604
//
LNMASK    OCTA  #0f0f0f0f0f0f0f0f
//
AVALUEND  OCTA  #21426384a5c6e723
BVALUEND  OCTA  #1324504254b81f23
//
PARMAVLN  BYTE  "Parameter A Value #"
PRAREG    BYTE  "________________",#a,0
PARMBVLN  BYTE  "Parameter B Value #"
PRBREG    BYTE  "________________",#a,0
//
MINMAXARS BYTE  "MINMAX Min Result #"
MMMINR    BYTE  "________________",#a,0
MINMAXBRS BYTE  "MINMAX Max Result #"
MMMAXR    BYTE  "________________",#a,0
//
          GREG  @
ABSVALRS  BYTE  "Abs Val Diff Res  #"
ABSVALRG  BYTE  "________________",#a,0
//
CLIPSMRS  BYTE  "Clip Sum Result   #"
CLIPSMRG  BYTE  "________________",#a,0
//
NYBDIFRS  BYTE  "Nyble Diff Result #"
NYBDIFRG  BYTE  "________________",#a,0
9H        IS    @                   // Data end
//
         LOC   8B                   // Text start
         LOC   #100
Main     IS    @
//
         PUSHJ  $0,GOMINMAX
         PUSHJ  $0,BlankLine
         PUSHJ  $0,GOABSVAL
         PUSHJ  $0,BlankLine
         PUSHJ  $0,GOCLIPSUM
         PUSHJ  $0,BlankLine
         PUSHJ  $0,GONYBDIFF
         TRAP   0,Halt,0            // Exit

// Common Parms
COMMPARMP IS     @
          GET    $8,rJ               // Save return
          GETA   $4,PUTMEMRD         // Reg converter
          LDOU   $17,AVALUE          // A-Value
          LDA    $18,PRAREG          // Output address
          PUSHGO $16,$4,0            // Call it
          LDOU   $17,BVALUE          // B-Value
          LDA    $18,PRBREG          // Output address
          PUSHGO $16,$4,0            // Call it
//
          LDA    $255,PARMAVLN
          TRAP   0,Fputs,StdOut      // Write it
          LDA    $255,PARMBVLN
          TRAP   0,Fputs,StdOut      // Write it
          PUT    rJ,$8              // Set Ret Addr          
          POP    0,0                // Return (no data)         
          
// Bytewise max and min
GOMINMAX  IS     @
          GET    $8,rJ               // Save return
          PUSHJ  $16,COMMPARMP       // COmmon parm print
//
          LDOU   $0,AVALUE           // A-Value again
          LDOU   $1,BVALUE           // B-Value again
          PUSHJ  $16,MAXMIN          // Call calculation
//
          GETA   $4,PUTMEMRD         // Reg converter
          SET    $5,$16              // Save Maxima
          SET    $6,$17              // Save Minima
          SET    $17,$6              // Mimima store
          LDA    $18,MMMINR
          PUSHGO $16,$4,0
          SET    $17,$5              // Maxima store
          LDA    $18,MMMAXR
          PUSHGO $16,$4,0
//
          LDA    $255,MINMAXARS
          TRAP   0,Fputs,StdOut      // Write it
          LDA    $255,MINMAXBRS
          TRAP   0,Fputs,StdOut      // Write it
//
          PUT    rJ,$8              // Set Ret Addr          
          POP    0,0                // Return (no data)         

// Absolute value
GOABSVAL  IS     @
          GET    $8,rJ               // Save return
          PUSHJ  $16,COMMPARMP       // COmmon parm print
//
          LDOU   $0,AVALUE           // A-Value again
          LDOU   $1,BVALUE           // B-Value again
          PUSHJ  $16,DABSVALUE          // Call calculation
//
          GETA   $4,PUTMEMRD         // Reg converter
          SET    $17,$16
          LDA    $18,ABSVALRG
          PUSHGO $16,$4,0
//
          LDA    $255,ABSVALRS
          TRAP   0,Fputs,StdOut      // Write it
          PUT    rJ,$8              // Set Ret Addr          
          POP    0,0                // Return (no data)         
// Clipsum
GOCLIPSUM IS     @
          GET    $8,rJ               // Save return
          PUSHJ  $16,COMMPARMP       // COmmon parm print
//
          LDOU   $0,AVALUE           // A-Value again
          LDOU   $1,BVALUE           // B-Value again
          PUSHJ  $16,CLIPSUM          // Call calculation
//
          GETA   $4,PUTMEMRD         // Reg converter
          SET    $17,$16
          LDA    $18,CLIPSMRG
          PUSHGO $16,$4,0
//
          LDA    $255,CLIPSMRS
          TRAP   0,Fputs,StdOut      // Write it
          PUT    rJ,$8              // Set Ret Addr          
          POP    0,0                // Return (no data)         
// Nybble Diff
GONYBDIFF IS     @
          GET    $8,rJ               // Save return
          GETA   $4,PUTMEMRD         // Reg converter
          LDOU   $17,AVALUEND          // A-Value
          LDA    $18,PRAREG          // Output address
          PUSHGO $16,$4,0            // Call it
          LDOU   $17,BVALUEND          // B-Value
          LDA    $18,PRBREG          // Output address
          PUSHGO $16,$4,0            // Call it
//
          LDA    $255,PARMAVLN
          TRAP   0,Fputs,StdOut      // Write it
          LDA    $255,PARMBVLN
          TRAP   0,Fputs,StdOut      // Write it
//
          LDOU   $0,AVALUEND           // A-Value again
          LDOU   $1,BVALUEND           // B-Value again
          PUSHJ  $16,NYBDIFF          // Call calculation
//
          SET    $17,$16
          LDA    $18,NYBDIFRG
          PUSHGO $16,$4,0
//
          LDA    $255,NYBDIFRS
          TRAP   0,Fputs,StdOut      // Write it
          PUT    rJ,$8              // Set Ret Addr          
          POP    0,0                // Return (no data)         

// Bytewise max and min
MAXMIN   IS    @
         LDOU  $1,AVALUE // a
         LDOU  $2,BVALUE // b
// x -> $3
// c -> $4 (maxima)
// d -> $5 (minima)
         BDIF  $3,$1,$2     // x,a,b
         ADDU  $4,$3,$2     // c,x,b
         SUBU  $5,$1,$3     // d,a,x
         SET   $0,$5        // Return value (minima)
         SET   $1,$4        // Return value (maxima)
         POP   2,0 // Return

// Absolute value of the diff
DABSVALUE IS    @
         LDOU  $1,AVALUE // a
         LDOU  $2,BVALUE // b
// x -> $3
// y -> $4
// e -> $5
         BDIF  $3,$1,$2     // x,a,b
         BDIF  $4,$2,$1     // y,b,a
         OR    $5,$3,$4     // e,x,y
         SET   $0,$5        // Ret val
         POP   1,0 // Return

// Clip summ
CLIPSUM  IS    @
         LDOU  $1,AVALUE // a
         LDOU  $2,BVALUE // b
// acomp -> $3
// x -> $4
// clippedsums -> $5
         NOR   $3,$1,0      // acomp,a,0
         BDIF  $4,$3,$2     // x,acomp,b
         NOR   $5,$4,0      // clippedsums,x,0
         SET   $0,$5        // Ret val
         POP   1,0 // Ret

// Nybble diff
NYBDIFF  IS    @
         LDOU  $1,AVALUEND // a
         LDOU  $2,BVALUEND // b
// m -> $3
// x -> $4
// y -> $5
// xx -> $6
// yy -> $7
// ans -> $8

         LDOU  $3,LNMASK
         AND   $4,$1,$3     // x,a,m
         AND   $5,$2,$3     // y,b,m
         ANDN  $6,$1,$3     // xx,a,m
         ANDN  $7,$2,$3     // yy,b,m
         BDIF  $4,$4,$5     // x,x,y
         BDIF  $6,$6,$7     // xx,xx,yy
         OR    $8,$4,$6     // ans,x,xx
         SET   $0,$8        // Ret val
         POP   1,0 // Ret

8H       IS    @                // Text end
//*ENDbddemo.mms
