// Start Data Segment
         LOC    Data_Segment
         GREG   @                   // Base Register
9H       IS     @                   // 9B/9H for data start/end
// Start Code/Text Segment
         LOC    #100
8H       IS     @                   // 8B/8H for code start/end
