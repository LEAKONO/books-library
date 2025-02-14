class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Encode a JWT token with the user ID
      token = encode_token(user_id: user.id)
      render json: { message: "Logged in successfully!", token: token }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def destroy
    # In a stateless JWT setup, no need to invalidate the token, but you could optionally handle it here if necessary
    render json: { message: "Logged out successfully!" }, status: :ok
  end

  private

  # Helper method to encode JWT token
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
