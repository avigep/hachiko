class ApplicationController < ActionController::API
  
  API_SCOPES = {
    user_write: 'users:write',
    weather_read: 'weather:read'
  }

  def render_unauthorized
    render json: { message: 'Unauthorized access' }, status: :unauthorized
  end

  def render_bad_request(message)
    render json: { message: message }, status: :bad_request
  end

  private

  def authorize_user_write
    render_unauthorized unless valid_access?(API_SCOPES[:user_write])
  end

  def authorize_weather_read
    render_unauthorized unless valid_access?(API_SCOPES[:weather_read])
  end

  def valid_access?(scope)
    token = fetch_token_from_headers
    token.present? && token.scopes.include?(scope)
  end

  def fetch_token_from_headers
    if request.env['HTTP_AUTHORIZATION'].present?
      access_key = request.env['HTTP_AUTHORIZATION'].split(' ').last
      Token.find_by(key: access_key)
    end
  end
end
