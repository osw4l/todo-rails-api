class AuthenticationController < ApplicationController
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @user = User.find_by_email(login_params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { auth_token: token }, status: :created
    else
      render json: { error: 'invalid credentials' }, status: :unauthorized
    end
  end

  def logout
    @current_user.authentication_token = nil
    if @current_user.save
      render json: { success: "Logged out" }
    else
      render json: { error: "Failed to logout" }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
