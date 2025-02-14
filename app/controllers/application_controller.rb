class ApplicationController < ActionController::API
  # Call this method to ensure the user is authenticated
  def authenticate_user!
    decoded_token = decode_token
    if decoded_token
      @current_user = User.find_by(id: decoded_token[:user_id])
      # Ensure user exists in the database
      render json: { error: 'User not found' }, status: :unauthorized unless @current_user
    else
      render json: { error: 'Not authorized' }, status: :unauthorized
    end
  end

  private

  # Helper method to decode JWT token from the Authorization header
  def decode_token
    header = request.headers['Authorization']
    return nil if header.nil?

    token = header.split(' ').last
    begin
      JWT.decode(token, Rails.application.secret_key_base).first
    rescue JWT::DecodeError
      nil
    end
  end
end
