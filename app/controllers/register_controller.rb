class RegisterController < ApplicationController
  def sign_up
    if User.find_by_email(user_params[:email]).nil?
      user = User.new(user_params)
      if user.save
        render json: { user: user }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: {error: 'user already exists'}, status: :bad_request
    end
  end

  private

  def user_params
    # params.require(:user).permit(:full_name, :email, :password, :password_confirmation)
    params.permit(:full_name, :email, :password, :password_confirmation)
  end

end
