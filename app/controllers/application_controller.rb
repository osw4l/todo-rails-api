class ApplicationController < ActionController::API
  rescue_from ActionController::RoutingError, with: :render_404

  private

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
      if @current_user.authentication_token.nil?
        render json: { error: "Invalid token"}, status: :unauthorized
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def render_404
    render json: { error: '404 Not Found' }, status: :not_found
  end
end

