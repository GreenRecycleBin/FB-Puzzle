#!/usr/bin/ruby

n = gets.chomp.to_i

(1..n).each {|i|
  if i % 15 == 0
    puts 'Hop'
  elsif i % 3 == 0
    puts 'Hoppity'
  elsif i % 5 == 0
    puts 'Hophop'
  end
}
