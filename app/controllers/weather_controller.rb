class WeatherController < ApplicationController
  before_action :authorize_weather_read
  before_action :check_basic_params

  def forecast
    @weather_forecast = OpenWeatherMapService.fetch_weather_forecast(weather_params)

    render json: @weather_forecast
  end

  def current
    @weather_current = OpenWeatherMapService.fetch_weather_current(weather_params)

    render json: @weather_current
  end

  private

  def check_basic_params
    render_bad_request('latitude and/or longitude missing') if params[:lat].blank? || params[:lng].blank?
  end

  def weather_params
    params.permit(:lat, :lng)
  end
end