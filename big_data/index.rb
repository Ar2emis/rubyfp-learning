# frozen_string_literal: true

require 'csv'

FILENAME = 'iris.csv'

# Read data from csv
data = CSV.read(FILENAME, encoding: 'bom|utf-8', headers: true, converters: :numeric,
                          header_converters: :symbol)
# => #<CSV::Table mode:col_or_row row_count:151>

# Custom converters
number_rounder = ->(value) { /\d/.match?(value) ? value.to_f.round : value }
CSV.read(FILENAME, encoding: 'bom|utf-8', headers: true, converters: [number_rounder],
                   header_converters: :symbol)
# => [#<CSV::Row sepallength:5 sepalwidth:4 petallength:1 petalwidth:0 variety:"Setosa">, ...]

# Access column
data[:variety] # => ['Setosa', ...]

# Access row
data[0] # => #<CSV::Row sepallength:5.1 sepalwidth:3.5 petallength:1.4 petalwidth:0.2 variety:"Setosa">

# Access value
data[0][:variety] # => 'Setosa'
# or
data[:variety][0] # => 'Setosa'

# Filter rows
data.select { |row| row[:variety] == 'Setosa' }
# => [#<CSV::Row sepallength:5.1 sepalwidth:3.5 petallength:1.4 petalwidth:0.2 variety:"Setosa">, ...]

# Reject rows
data.reject { |row| row[:variety] == 'Setosa' }
# => [#<CSV::Row sepallength:7 sepalwidth:3.2 petallength:4.7 petalwidth:1.4 variety:"Versicolor">, ...]

# Sort rows
data.sort_by { |row| row[:sepallength] }
# => [#<CSV::Row sepallength:4.3 sepalwidth:3 petallength:1.1 petalwidth:0.1 variety:"Setosa">,
#     #<CSV::Row sepallength:4.4 sepalwidth:2.9 petallength:1.4 petalwidth:0.2 variety:"Setosa">,
#     ...]
# in descending order
data.sort_by { |row| row[:sepallength] }.reverse
# => [#<CSV::Row sepallength:7.9 sepalwidth:3.8 petallength:6.4 petalwidth:2 variety:"Virginica">,
#     #<CSV::Row sepallength:7.7 sepalwidth:3 petallength:6.1 petalwidth:2.3 variety:"Virginica">,
#     ...]

# Group by some field
data.group_by { |row| row[:variety] }
# => {"Setosa"=> [#<CSV::Row ... variety:"Setosa">, ...],
#     "Versicolor"=> [#<CSV::Row ... variety:"Versicolor">, ...],
#     "Virginica"=> [#<CSV::Row ... sepvariety:"Virginica">, ...]}

# More complete group by
grouped_data = data.group_by do |row|
  case row[:sepallength]
  when (0..4) then :short
  when (4..6) then :medium
  when (6..8) then :tall
  else :error
  end
end
# => {:medium=> [#<CSV::Row sepallength:5.1 ...>, ...],
#     :tall=> [#<CSV::Row sepallength:7 ...>, ...]}

# Row with max value
data.max_by { |row| row[:sepallength] }
# => #<CSV::Row sepallength:7.9 sepalwidth:3.8 petallength:6.4 petalwidth:2 variety:"Virginica">

# Row with min value
data.min_by { |row| row[:sepallength] }
# => #<CSV::Row sepallength:4.3 sepalwidth:3 petallength:1.1 petalwidth:0.1 variety:"Setosa">

# Average value in groups
grouped_data.transform_values do |rows|
  rows.sum { |row| row[:sepallength] } / rows.count
end
# => {:medium=>5.276404494382023, :tall=>6.670491803278688}

# Write to another file
File.open('result.csv', 'wb') { |file| file.write(data.to_csv) }
