class RespondersController < ApplicationController
  before_action :set_responder, only: [:show, :update]

  def create
    @responder = Responder.new(responder_create_params)
    if @responder.save
      render :show, status: :created
    else
      render json: { message: @responder.errors }, status: :unprocessable_entity
    end
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
  end

  def index
    if params[:show]
      render :capacity
    else
      @responders = Responder.all
      render :index
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
    @responder = Responder.find_by name: params[:id]
  end

  def responder_update_params
    params.require(:responder).permit(:on_duty)
  end

  def responder_create_params
    params.require(:responder).permit(:type, :name, :capacity)
  end
end
