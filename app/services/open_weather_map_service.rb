class OpenWeatherMapService
  class << self
    def fetch_forecast(params)
      { forecast: 'test forecase' }
    end

    def fetch_weather_now(params)
      { now: 'test now' }
    end
  end
end
