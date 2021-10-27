#
#
# Ruby and Math
#
#

#
# Arithmetics
#
1 + 1 # => 2

1 - 1 # => 0

1 * 2 # => 2

1 / 2 # => 0

2**2 # => 4

3 % 2 # => 1

# Sum
[1, 2, 3, 4].sum # => 10

# Sum of numbers with another
[1, 2, 3, 4].sum(2) # => 12

# Sum of negative numbers
[1, 2, 3, 4].sum { |number| -number } # => -10
# or simply
[1, 2, 3, 4].sum(&:-@) # => -10

# Difference of numbers with another
[1, 2, 3, 4].sum(2) { |number| -number } # => -8
# or simply
[1, 2, 3, 4].sum(2, &:-@) # => -8

# Sum of absolute values of the numbers
[1, -2, 3, -4].sum(&:abs) # => 10

# Multiplication
[1, 2, 3, 4].inject { |product, number| product * number } # => 24
# or simply
[1, 2, 3, 4].inject(&:*) # => 24

# Multiplication of numbers with another
[1, 2, 3, 4].inject(2) { |product, number| product * number } # => 48
# or simply
[1, 2, 3, 4].inject(2, &:*) # => 48

# Factorial
# (1..number) - range of numbers from 1 to <number>
# inject(1, &:*) - multiplication of numbers (will return 1 if number can't have factorial)
def factorial(number)
  (1..number).inject(1, &:*)
end

factorial(0) # => 0
factorial(1) # => 1
factorial(3) # => 6

# Double Factorial
def double_factorial(number)
  ((number.odd? ? 1 : 2)..number).step(2).inject(1, &:*)
end

double_factorial(0) # => 1
double_factorial(1) # => 1
double_factorial(4) # => 8
double_factorial(5) # => 15

# Progression
def a_n(a_zero, number, &block)
  number.times.inject(a_zero, &block)
end

a_n(0, 1) { |a_n_minus_one| a_n_minus_one * 2 + 1 } # => 1
a_n(0, 5) { |a_n_minus_one| a_n_minus_one * 2 + 1 } # => 31

def progression_sum(a_zero, number, &block)
  number.times.sum { |index| a_n(a_zero, index.next, &block) }
end

progression_sum(0, 2) { |a_n_minus_one| a_n_minus_one * 2 + 1 } # => 4
progression_sum(0, 5) { |a_n_minus_one| a_n_minus_one * 2 + 1 } # => 57

def progression_product(a_zero, number, &block)
  number.times.inject(1) { |product, index| product * a_n(a_zero, index.next, &block) }
end

progression_product(0, 2) { |a_n_minus_one| a_n_minus_one * 2 + 1 } # => 3
progression_product(0, 5) { |a_n_minus_one| a_n_minus_one * 2 + 1 } # => 9765 :)

#
# Math module
#
Math::E # => 2.718281828459045
Math::PI # => 3.141592653589793

# Square Root
Math.sqrt(4) # => 2.0

# Cube Root
Math.cbrt(8) # => 2.0

# E ** x
Math.exp(2) # => 7.38905609893065

# Logarithm (by default base is E)
Math.log(2, 2) # => 1.0

# Base 10 Logarithm
Math.log10(100) # => 2.0

# Base 2 Logarithm
Math.log2(4) # => 2.0

# Hypotenuse
Math.hypot(3, 4) # => 5.0

# cos
Math.cos(0) # => 1.0

# sin
Math.sin(0) # => 0.0

# tan
Math.tan(0) # => 0.0

# acos
Math.acos(0) # => 1.5707963267948966

# asin
Math.asin(1) # => 1.5707963267948966

# And lots of other amazing staff
