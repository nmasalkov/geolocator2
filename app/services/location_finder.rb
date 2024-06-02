class LocationFinder
  attr_reader :source, :type
  def initialize(search_params)
    @source = search_params[:source]
    @type = search_params[:type]
  end

  def call
    if type == 'ip_address'
      Location.find_by(ip_address: source)
    else
      Location.where(url: source).or(Location.where(url: alternative_url_source)).take
    end
  end

  private

  def alternative_url_source
    if source.starts_with?('http://')
      source.sub('http://', 'https://')
    else
      source.sub('https://', 'http://')
    end
  end
end
