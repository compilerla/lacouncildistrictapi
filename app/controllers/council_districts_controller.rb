class CouncilDistrictsController < ApplicationController
  def index
    if params[:address].present?
      if Geocoder.search(params[:address]).any?
        coords = Geocoder.search(params[:address]).first.coordinates
        @district = CouncilDistrict.where_lat_lon(*coords).first
      end
    end
  end
end