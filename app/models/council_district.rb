require 'rgeo/geo_json'

class CouncilDistrict < ActiveRecord::Base
  scope :containing_point, -> (point) { where("ST_Intersects(council_districts.shape, ?)", point) }

  def self.to_geojson
    features = all.map do |district|
      district.as_geojson
    end

    {
      type: 'FeatureCollection',
      features: features
    }.to_json
  end

  def as_geojson
    {
      type: 'Feature',
      geometry: RGeo::GeoJSON.encode(shape),
      properties: {}
    }
  end

  def self.where_lat_lon(lat, lon)
    factory = RGeo::Geographic.simple_mercator_factory()
    point = factory.point(lon, lat).to_s
    self.containing_point(point)
  end
end