class LocationCreator
  attr_accessor :location
  attr_reader :type, :message, :source, :created

  def initialize(params)
    @source = params[:source]
    @type = params[:type]
    @location = Location.new
  end

  def call
    prepare_sources
    find_coordinates
    save_location
  rescue SocketError
    unresolved_ip_result
  rescue CoordinatesFinder::CoordinatesNotFound
    unresolved_coordinates_result
  rescue ActiveRecord::StatementInvalid, ActiveRecord::ConnectionTimeoutError
    unresolved_record_saving
  end

  private

  def prepare_sources
    SourcesPreparer.call(type, source, location)
  end

  def find_coordinates
    coordinates = coordinates_filler.call
    location.latitude = coordinates[:latitude].to_f
    location.longitude = coordinates[:longitude].to_f
  end

  def save_location
    if location.save
      @location = LocationsBlueprint.render_as_struct(location)
      @message = 'Location was detected and saved'
      @created = true
    elsif location.errors
      unresolved_record_saving(error: location.errors.full_messages.join(', '))
    end
  end

  def unresolved_ip_result
    @message = "unable to locate IP address for url #{location.url}"
    @location = {}
  end

  def unresolved_coordinates_result
    @message = 'unable to locate IP address'
    @location = {}
  end

  def unresolved_record_saving(error: nil)
    @message = 'Location was detected, but we were unable to save it'
    @message.concat(" because of: #{error}") if error
    @location = LocationsBlueprint.render_as_struct(location)
  end

  def coordinates_filler
    @coordinates_filler ||= CoordinatesFinder.new(location)
  end
end
