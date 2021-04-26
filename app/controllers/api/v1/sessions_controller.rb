class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if session_params[:email].nil? && session_params[:password].nil?
      render json: { body: 'Missing email and password' }, status: :unauthorized
    elsif session_params[:email].nil?
      render json: { body: 'Missing email' }, status: :unauthorized
    elsif session_params[:password].nil?
      render json: { body: 'Missing password' }, status: :unauthorized
    elsif user && user.authenticate(session_params[:password])
      render json: UserSerializer.new(user)
    elsif user && !user.authenticate(session_params[:password])
      render json: { body: 'Your credentials are incorrect' }, status: :unauthorized
    elsif user.nil?
      render json: { body: 'Your credentials are incorrect' }, status: :unauthorized
    end
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
