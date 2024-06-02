# frozen_string_literal: true

class SearchParamsBlueprint < Blueprinter::Base
  field :type

  field :source do |object|
    source = object[:source].strip

    object['type'] == 'ip_address' ? source : self.prepared_url(source)
  end

  def self.prepared_url(source)
    if source.start_with?('http://', 'https://')
      formatted_source = source
    elsif source.start_with?('www.')
      formatted_source = "http://#{source[4..-1]}"
    else
      formatted_source = "https://#{source}"
    end

    formatted_source
  end
end
