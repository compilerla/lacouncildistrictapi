# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rgeo/shapefile'

path = 'db/shapes/geo_export_f9a1d340-d921-4cd5-b716-71441f4e58ed.shp'
RGeo::Shapefile::Reader.open(path) do |file|
  puts "File contains #{file.num_records} records."
  file.each do |record|
    CouncilDistrict.find_or_create_by(district_number: record.attributes['district'], shape: record.geometry)
    # puts "Record number #{record.index}:"
    # puts "  Geometry: #{record.geometry.as_text}"
    # puts "  Attributes: #{record.attributes.inspect}"
  end
  file.rewind
  record = file.next
  puts "First record geometry was: #{record.geometry.as_text}"
end