// Start Data Segment
         LOC    Data_Segment
         GREG   @                   // Base Register
9H       IS     @                   // 9H/9B for data
// Start Code/Text Segment
         LOC    #100
8H       IS     @                   // 8H/8B for code
