# frozen_string_literal: true

class CoordinatesFinder
  class CoordinatesNotFound < StandardError; end

  attr_reader :location

  def initialize(location)
    @location = location
  end

  def call
    response = Ipstack.new(location.ip_address).find_location
    response ||= geocoder_response

    raise CoordinatesNotFound unless response

    response
  end

  def geocoder_response
    response = Geocoder.search(location.ip_address)&.first
    extract_geocoder_data(response) if response
  end

  def extract_geocoder_data(response)
    location_data = response&.data&.dig('loc')
    latitude = location_data&.split(',').try(:at, 0)
    longitude = location_data&.split(',').try(:at, 1)

    return unless latitude && longitude

    {
      latitude: latitude,
      longitude: longitude
    }
  end
end
