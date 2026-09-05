class ShortUrlsController < ApplicationController
  def index
    short_urls = ShortUrl.all

    render json: short_urls.as_json(
      methods: :is_expired?,
      except: [:created_at, :updated_at, :user_id, :expires_at]
    ), status: :ok
  end

  def create
    short_url = ShortUrl.create(short_url_params)
    short_url.short_code = ShortUrl.shortened_code
    begin
      short_url.save
    rescue ActiveRecord::RecordInvalid => e
      render json: {error: e.message}, status: :unprocessable_entity
    end

    render json: short_url, status: :created
  end

  def show
    short_url = ShortUrl.find_by(short_code: params[:short_code])
    if short_url and !short_url.is_expired?
      redirect_to short_url.long_url
    else
      render json: {error: "Short URL not found"}, status: :not_found
    end
  end

  def destroy
    short_url = ShortUrl.find_by(short_code: params[:short_code])
    begin 
      short_url.destroy
      render json: {message: "Short URL deleted successfully"}, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: {error: e.message}, status: :not_found
    end
  end

  private

  def short_url_params
    params.permit(:long_url, :expires_at)
  end
end
