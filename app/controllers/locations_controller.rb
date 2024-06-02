class LocationsController < ApplicationController
  before_action :check_input, only: [:search]

  def index
    @locations = Location.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def respond_with_existing_location
    @location = existing_location
    @message = 'Location is taken from saved'

    respond
  end

  def search
    existing_location ? respond_with_existing_location : respond_with_new_location
  end

  private

  def respond_with_new_location
    creator = LocationCreator.new(@search_params)
    creator.call
    @location = creator.location
    @message = creator.message

    respond
  end

  def respond
    respond_to do |format|
      format.turbo_stream
    end
  end

  def existing_location
    @existing_location = LocationFinder.new(search_params).call
  end

  def search_params
    permitted_params = params.permit(:source, :type).to_unsafe_hash
    @search_params ||= SearchParamsBlueprint.render_as_hash(permitted_params)
  end

  def source
    @source ||= search_params[:source]
  end

  def type
    @type ||= search_params[:type]
  end

  def check_input
    @message = LocationsCreateContract.new.call(search_params).errors

    respond if @message
  end
end

