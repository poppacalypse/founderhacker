# practice writing methods that leverage variables, operators, and conditionals

# 1. write a method that returns:
# => "if you were as old as your name is long, you would be X years old!"
# hints: your method should accept 1 argument, a name. "X" should be a number.

#ADC
def name_age(name)
  "if you were as old as your name is long, you would be #{name.length} years old!"
end

#FH
def name_to_age(name)
  would_be_age = name.length
  puts "If you were as old as your name is long, you would be #{would_be_age} years old!"
end


# 2. write a method that accepts 3 arguments (all numbers) and returns the largest one

#ADC
def largest(a, b, c)
  if a > b && a > c
    a
  elsif b > a && b > c 
    b
  else 
    c
  end
end

# FH simple, hack solution
def largest_num(num1, num2, num3)
  highest_num = 0
  highest_num = num1 if num1 > highest_num
  highest_num = num2 if num2 > highest_num
  highest_num = num3 if num3 > highest_num
  
  highest_num
end

# FH preferred solution (requires looking up native ruby api)
def largest_num(num1, num2, num3)
  [num1, num2, num3].max
end

# 3. review the following code and determine what the result will be (without pasting into IRB)

num = 17.3

def number(num)
  if num.to_i.even?
    puts "number is even!"
  elsif num.to_i.odd?
    if num.to_f == num.to_i
      puts "coercion OK"
    else
      (10 % 5).zero? ? (puts "number is even!") : (puts "number is odd!")
    end
  else
    puts "number is not even or odd!"
  end
end
# => what will be printed out?

# => "number is even!" (Line 34)

# 1. 17.3 is a float, so it does not have "even?" and "odd?" method available (we covered this)
# 2. because Line 52 is false, we're now operating on Line 54
# 3. "num.to_f == num.to_i" will compare 17.3 == 17.0, which is false
# 4. because Line 55 is false, we're now operating on Line 58
# 5. (10 % 5) returns zero, because there is no modulus (remainder) when dividing 10 by 5
# 6. as you can infer, the "zero?" method works just like "even?" and "odd?". this returns true (0.zero?)
# 7. because the "if" ternary on Line 58 is true, the middle block executes
# 8. although 17.3 ('num' variable) is not even, Line 34 middle block is 'puts "number is even!"'
