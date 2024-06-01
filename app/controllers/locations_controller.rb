class LocationsController < ApplicationController
  def index
    @locations = Location.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
