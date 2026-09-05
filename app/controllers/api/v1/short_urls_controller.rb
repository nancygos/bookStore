class Api::V1::ShortUrlsController < ApplicationController
  def index
    short_urls = ShortUrl.all

    render json: short_urls.as_json(
      methods: :is_expired?,
      except: [:created_at, :updated_at, :user_id]
    ), status: :ok
  end

  def create
    short_url = ShortUrl.new(short_url_params)
    short_url.short_code = ShortUrl.shortened_code

    if short_url.save
      render json: short_url.as_json(methods: :is_expired?), status: :created
    else
      render json: { error: short_url.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def show
    short_url = ShortUrl.find_by(short_code: params[:short_code] || params[:id])
    if short_url && !short_url.is_expired?
      redirect_to short_url.long_url
    else
      render json: { error: "Short URL not found" }, status: :not_found
    end
  end

  def destroy
    short_url = ShortUrl.find_by(id: params[:id]) || ShortUrl.find_by(short_code: params[:id])
    if short_url
      short_url.destroy
      render json: { message: "Short URL deleted successfully" }, status: :ok
    else
      render json: { error: "Short URL not found" }, status: :not_found
    end
  end

  private

  def short_url_params
    params.permit(:long_url, :expires_at, :user_id)
  end
end
