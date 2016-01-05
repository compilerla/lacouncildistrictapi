require 'rgeo/geo_json'

class CouncilDistrict < ActiveRecord::Base
  GEO_FACTORY = RGeo::Geographic.spherical_factory(srid: 4326)

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
end