# frozen_string_literal: true

require 'csv'

require 'gruff'
require 'pry'

FILENAME = 'iris.csv'
SIZE = 1080
NUMERIC_COLUMNS = %i[sepallength sepalwidth petallength petalwidth].freeze

def chart_path(name)
  File.join('images', "#{name}.png")
end

def iris_by_variety(&block)
  data = CSV.read(FILENAME, encoding: 'bom|utf-8', headers: true, converters: :numeric,
                            header_converters: :symbol)
  iris_by_variety = data.group_by { |row| row[:variety] }
  block ? iris_by_variety.each { |variety, irises| block[variety, irises] } : iris_by_variety
end

# Sepal length bar by variety
bar = Gruff::Bar.new(SIZE)
bar.minimum_value = 0
bar.title = 'Sepal Length Bar'
iris_by_variety do |variety, irises|
  lengths = irises.map { |iris| iris[:sepallength] }
  bar.data(variety, [lengths.min, lengths.sum / lengths.count, lengths.max])
end
bar.write(chart_path(:bar))

# Pie chart by variety
pie = Gruff::Pie.new(SIZE)
pie.title = 'Variety Count Pie'
iris_by_variety do |variety, irises|
  pie.data(variety, irises.count)
end
pie.write(chart_path(:pie))

# Spider charts for each variety
iris_by_variety do |variety, irises|
  spider = Gruff::Spider.new(SIZE)
  spider.title_margin = 100
  spider.bottom_margin = 100
  spider.title = "#{variety.to_s.capitalize} Properties"
  irises = irises.map { |iris| iris.to_h.slice(*NUMERIC_COLUMNS) }
  NUMERIC_COLUMNS.each do |property|
    spider.data(property, irises.map { |iris| iris[property] }.sum / irises.count * 100)
  end
  spider.write(chart_path("#{variety}_spider"))
end
