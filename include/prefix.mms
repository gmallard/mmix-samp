//*BEGIN prefix.mms
//--------------------------------------------------------------------
// Start Data Segment
          LOC    Data_Segment        // Start data
          GREG   @                   // Start date base
//--------------------------------------------------------------------
// Subroutine gregisters
// 32 Base
cr32      IS     $32                 // Call register
pr32a     IS     $33                 // Parameter register
pr32b     IS     $34                 // Parameter register
pr32c     IS     $35                 // Parameter register
// 16 Base
cr16      IS     $15                 // Call register
pr16a     IS     $17                 // Parameter register
pr16b     IS     $18                 // Parameter register
pr16c     IS     $19                 // Parameter register
// 8 Base
cr8       IS     $8                 // Call register
pr8a      IS     $9                 // Parameter register
pr8b      IS     $10                // Parameter register
pr8c      IS     $11                // Parameter register
// 4 Base
cr4       IS     $4                 // Call register
pr4a      IS     $5                 // Parameter register
pr4b      IS     $6                 // Parameter register
pr4c      IS     $7                 // Parameter register
9H        IS     @                  // End data
//--------------------------------------------------------------------
          LOC    #100               // Start code
8H        IS     @
/--------------------------------------------------------------------
//*END prefix.mms
