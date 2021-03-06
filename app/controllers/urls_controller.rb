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
      render json: {short_url: @url.short_url,
        message: "please copy the url and paste in browser"}
    else
    	render 'new'
    end
  end

  def show
  	short_url = params[:id]
    @url = Url.find_by(short_url: "#{"http://localhost:3000/urls"}/#{short_url}")
    redirect_to @url.sanitize
	end
  end
  private
  def url_params
    params.require(:url).permit(:long_url)
  end
