#
valsm = [2,4,8,16]
valsn = [2,4,8,16]
#
valsm.each do |m|
  valsn.each do |n|
    puts "=" * 60
    #
    puts "Form 1:"
=begin
mADDU $X,$Y,0 // x <= m*y
nADDU $X,$X,0 // x <= n*x == n*(m*y) 
-> n*m*y
=end
    puts "  #{m}ADDU $0,$2,0"
    puts "  #{n}ADDU $0,$0,0"
    puts "  -> n*m*y -->(#{n},#{n}):#{n*m}y"
    #
    puts "Form 2:"
=begin
mADDU $X,$Y,0 // x <= m*y
nADDU $X,$X,$X // x <= n*x + x == n*(m*y) + m*y
-> (n+1)*m*y
=end
    puts "  #{m}ADDU $0,$2,0"
    puts "  #{n}ADDU $0,$0,$0"
    puts "  -> (n+1)*m*y -->(#{n},#{n}):#{(n+1)*m}y"
    #
    puts "Form 3:"
=begin
mADDU $X,$Y,0 // x <= m*y
nADDU $X,$X,$Y // x <= n*x + y == n*(m*y) + y
-> n*(m*y) + y
=end
    puts "  #{m}ADDU $0,$2,0"
    puts "  #{n}ADDU $0,$0,$2"
    puts "  -> n*(m*y) + y -->(#{n},#{n}):#{n*m+1}y"
    #
    puts "Form 4:"
=begin
mADDU $X,$Y,0 // x <= m*y
nADDU $X,$Y,$X // x <= n*y + x == n*y + m*y == (m+n)*y
-> (m+n)*y
=end
    puts "  #{m}ADDU $0,$2,0"
    puts "  #{n}ADDU $0,$2,$0"
    puts "  -> (m+n)*y -->(#{n},#{n}):#{m+n}y"
    #
    puts "Form 5:"
=begin
mADDU $X,$Y,$Y // x <= m*y + y == (m+1)*y
nADDU $X,$X,0 // x <= n*x == n*(m+1)*y
-> n*(m+1)*y
=end
    puts "  #{m}ADDU $0,$2,$2"
    puts "  #{n}ADDU $0,$0,0"
    puts "  -> n*(m+1)*y -->(#{n},#{n}):#{n*(m+1)}y"
    #
    puts "Form 6:"
=begin
mADDU $X,$Y,$Y // x <= m*y + y == (m+1)*y
nADDU $X,$X,$X // x <= n*x + x == n*(m+1)*y + (m+1)*y
              // == (n+1)*(m+1)*y
-> (n+1)*(m+1)*y
=end
    puts "  #{m}ADDU $0,$2,$2"
    puts "  #{n}ADDU $0,$0,$0"
    puts "  -> (n+1)*(m+1)*y -->(#{n},#{n}):#{(n+1)*(m+1)}y"
    #
    puts "Form 7:"
=begin
mADDU $X,$Y,$Y // x <= m*y + y == (m+1)*y
nADDU $X,$X,$Y // x <= n*x + y == n*(m+1)*y + y
              // == (n*(m+1)+1)*y
-> (n*(m+1)+1)*y
=end
    puts "  #{m}ADDU $0,$2,$2"
    puts "  #{n}ADDU $0,$0,$2"
    puts "  -> (n*(m+1)+1)*y -->(#{n},#{n}):#{n*(m+1)+1}y"
    #
    puts "Form 8:"
=begin
mADDU $X,$Y,$Y // x <= m*y + y == (m+1)*y
nADDU $X,$Y,$X // x <= n*y + x == n*y + (m+1)*y
              // == (n+m+1)*y
-> (n+m+1)*y
=end
    puts "  #{m}ADDU $0,$2,$2"
    puts "  #{n}ADDU $0,$2,$0"
    puts "  -> (n+m+1)*y -->(#{n},#{n}):#{n+m+1}y"
  end
end


