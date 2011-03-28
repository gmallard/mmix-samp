#
valsm = [2,4,8,16]
valsn = [2,4,8,16]
#
valsm.each do |m|
  valsn.each do |n|
    puts "=" * 60
    #
    puts "Form 1:"
    puts "  #{m}ADDU $0,$2,0"
    puts "  #{n}ADDU $0,$2,0"
    puts "  -> n*m*y --> #{n*m}y"
    #
    puts "Form 2:"
    puts "  #{m}ADDU $0,$2,0"
    puts "  #{n}ADDU $0,$2,$0"
    puts "  -> (n+1)*m*y --> #{(n+1)*m}y"
    #
    puts "Form 3:"
    puts "  #{m}ADDU $0,$2,0"
    puts "  #{n}ADDU $0,$0,$2"
    puts "  -> n*(m*y) + y --> #{n*m+1}y"
    #
    puts "Form 4:"
    puts "  #{m}ADDU $0,$2,0"
    puts "  #{n}ADDU $0,$2,$0"
    puts "  -> (m+n)*y --> #{m+n}y"
    #
    puts "Form 5:"
    puts "  #{m}ADDU $0,$2,$2"
    puts "  #{n}ADDU $0,$0,0"
    puts "  -> n*m*y --> #{n*m}y"
    #
    puts "Form 6:"
    puts "  #{m}ADDU $0,$2,$2"
    puts "  #{n}ADDU $0,$0,$0"
    puts "  -> (n+1)*(m+1)*y --> #{(n+1)*(m+1)}y"
    #
    puts "Form 7:"
    puts "  #{m}ADDU $0,$2,$2"
    puts "  #{n}ADDU $0,$0,$2"
    puts "  -> (n*(m+1)+1)*y --> #{n*(m+1)+1}y"
    #
    puts "Form 8:"
    puts "  #{m}ADDU $0,$2,$2"
    puts "  #{n}ADDU $0,$2,$0"
    puts "  -> (n+m+1)*y --> #{n+m+1}y"
  end
end


