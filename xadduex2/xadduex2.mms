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
9H        IS    @
// Code
          LOC   8B
Main      IS    @
//
// Verify code generator results for m=2, n=2.
//
// Form1: -> n*m*y -->(2,2):4y
          SETL  $2,42
          2ADDU $0,$2,0
          2ADDU $0,$2,0
// Form2: -> (n+1)*m*y -->(2,2):6y
          SETL  $2,42
          2ADDU $0,$2,0
          2ADDU $0,$0,$0
// Form3: -> n*(m*y) + y -->(2,2):5y
          SETL  $2,42
          2ADDU $0,$2,0
          2ADDU $0,$0,$2
// Form4: -> (m+n)*y -->(2,2):4y
          SETL  $2,42
          2ADDU $0,$2,0
          2ADDU $0,$2,$0
// Form5: -> n*m*y --> 4y -->(2,2):6y
          SETL  $2,42
          2ADDU $0,$2,$2
          2ADDU $0,$0,0
// Form6: -> (n+1)*(m+1)*y -->(2,2):9y
          SETL  $2,42
          2ADDU $0,$2,$2
          2ADDU $0,$0,$0
// Form7: -> (n*(m+1)+1)*y -->(2,2):7y
          SETL  $2,42
          2ADDU $0,$2,$2
          2ADDU $0,$0,$2
// Form8: -> (n+m+1)*y -->(2,2):5y
          SETL  $2,42
          2ADDU $0,$2,$2
          2ADDU $0,$2,$0
//
          TRAP  0,Halt,0            // Exit
8H        IS    @

