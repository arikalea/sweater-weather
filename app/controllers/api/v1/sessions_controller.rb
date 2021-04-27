class Api::V1::SessionsController < ApplicationController
  before_action :validate_params

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      render json: UserSerializer.new(user)
    elsif user && !user.authenticate(session_params[:password])
      render json: { error: 'Your credentials are bad' }, status: :unauthorized
    else
      render json: { error: 'Your credentials are bad' }, status: :unauthorized
    end
  end

  private

  def validate_params
    if request.body.read.blank?
      render json: { error: 'Your credentials are bad' }, status: :bad_request
    end
  end

  def session_params
    params.permit(:email, :password)
  end
end
