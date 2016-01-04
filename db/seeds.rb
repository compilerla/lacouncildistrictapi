# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rgeo/shapefile'

path = 'db/shapes/CnclDist_July2012.shp'
RGeo::Shapefile::Reader.open(path) do |file|
  puts "File contains #{file.num_records} records."
  file.each do |record|
    CouncilDistrict.find_or_create_by(district_number: record.attributes['DISTRICT'], shape: record.geometry)
    puts "Record number #{record.index}:"
    puts "  Geometry: #{record.geometry.as_text}"
    puts "  Attributes: #{record.attributes.inspect}"
  end
  file.rewind
  record = file.next
  puts "First record geometry was: #{record.geometry.as_text}"
end