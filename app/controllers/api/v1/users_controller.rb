class Api::V1::UsersController < ApplicationController
  before_action :validate_params

  def create
    user = User.create(user_params)
    if user.save
      render json: UserSerializer.new(user), status: :created
    else
      render json: { error: user.errors.full_messages.to_sentence }, status: 400
    end
  end

  private

  def validate_params
    if request.body.read.blank?
      render json: { error: 'Must provide request body' }, status: :bad_request
    end
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
