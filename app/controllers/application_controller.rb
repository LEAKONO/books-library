class ApplicationController < ActionController::API
  before_action :authenticate_user!

  private

  def authenticate_user!
    decoded_token = decode_token
    if decoded_token
      Rails.logger.debug("Decoded token: #{decoded_token}")  # Debugging log
      @current_user = User.find_by(id: decoded_token["user_id"])

      unless @current_user
        render json: { error: 'User not found' }, status: :unauthorized
      end
    else
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end

  def decode_token
    header = request.headers['Authorization']
    return nil if header.blank?

    token = header.split(' ').last
    begin
      decoded = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first
      decoded  # Returns decoded payload
    rescue JWT::DecodeError
      Rails.logger.error("JWT Decode Error: Invalid token")
      nil
    end
  end
end
