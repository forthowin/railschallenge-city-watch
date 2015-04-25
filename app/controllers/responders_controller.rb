class RespondersController < ApplicationController
  before_action :set_responder, only: [:show, :update]

  def create
    @responder = Responder.new(responder_create_params)
    if @responder.save
      render :show, status: :created
    else
      render json: { message: @responder.errors }, status: :unprocessable_entity
    end
    rescue ActionController::UnpermittedParameters => e
      render json: { message: e.message }, status: :unprocessable_entity
  end

  def show
    if @responder
      render :show
    else
      render json: nil, status: :not_found
    end
  end

  def update
    @responder.update(responder_update_params)
    render :show
    rescue ActionController::UnpermittedParameters => e
      render json: { message: e.message }, status: :unprocessable_entity
  end

  def index
    if params[:show]
      render :capacity
    else
      @responders = Responder.all
      render :index
    end
  end

  private

  def set_responder
    @responder = Responder.find_by name: params[:id]
  end

  def responder_update_params
    params.require(:responder).permit(:on_duty)
  end

  def on_duty_value
    to_bool(params[:responder].fetch(:on_duty))
  end

  def to_bool(str)
    str == 'true' || str == true
  end

  def responder_create_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
end
