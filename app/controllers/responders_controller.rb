class RespondersController < ApplicationController
  before_action :page_not_found, only: [:new, :edit, :destroy]
  before_action :set_responder, only: [:show, :update]

  def create
    @responder = Responder.new(responder_create_params)
    if @responder.save
      render 'responders/create.json', status: :created
    else
      render 'responders/create.json', status: :unprocessable_entity
    end
    rescue ActionController::UnpermittedParameters => e
      render json: { message: e.message }, status: :unprocessable_entity
  end

  def show
    if @responder
      render 'responders/show.json'
    else
      render json: nil, status: :not_found
    end
  end

  def update
    @responder.update(responder_update_params)
    render 'responders/update.json'
    rescue ActionController::UnpermittedParameters => e
      render json: { message: e.message }, status: :unprocessable_entity
  end

  def index
    if params[:show]
      render 'responders/capacity.json'
    else
      @responders = Responder.all
      render 'responders/index.json'
    end
  end

  def new
  end

  def edit
  end

  def destroy
  end

  private

  def set_responder
    @responder = Responder.find_by name: params[:name]
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
