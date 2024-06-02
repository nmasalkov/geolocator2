# frozen_string_literal: true

class LocationsBlueprint < Blueprinter::Base
  identifier :id

  fields :ip_address, :url, :longitude, :latitude

  def self.render_as_struct(data)
    OpenStruct.new(self.render_as_hash(data))
  end
end
