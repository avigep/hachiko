require 'open_weather'

class OpenWeatherMapService
  class << self
    def fetch_weather_forecast(params)
      OpenWeather::Forecast.geocode(
        params[:lat],
        params[:lng], 
        open_weather_api_options
      )
    end

    def fetch_weather_current(params)
      OpenWeather::Current.geocode(
        params[:lat],
        params[:lng], 
        open_weather_api_options
      )
    end

    private

    def open_weather_api_options
      { units: "metric", APPID: ENV['WEATHER_API_KEY'] }
    end
  end
end
