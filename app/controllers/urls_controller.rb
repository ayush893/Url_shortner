class UrlsController < ApplicationController
  def index
    @urls = Url.all
  end
  def new
    @url = Url.new
  end
  def create
    @url = Url.new(url_params)
    short_url =@url.generate_short_url
    @url.short_url = "#{"http://localhost:3000/urls"}/#{short_url}"
    @url.long_url = @url.sanitize
    if @url.save
    	$url_id = @url.id
      render json: @url.short_url
    else
    	render 'new'
    end
  end

  def show
    @url = Url.find_by(id: $url_id)
    redirect_to @url.sanitize
  end
  private
  def url_params
    params.require(:url).permit(:long_url)
  end
end
