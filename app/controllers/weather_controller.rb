class WeatherController < ApplicationController
  def forecast
    @weather_forecast = OpenWeatherMapService.fetch_forecast(weather_forecast_params)

    render json: @weather_forecast
  end

  def now
    @weather_current = OpenWeatherMapService.fetch_weather_now(weather_current_params)

    render json: @weather_current
  end

  private

  def weather_forecast_params
    {}
  end

  def weather_current_params
    {}
  end
end