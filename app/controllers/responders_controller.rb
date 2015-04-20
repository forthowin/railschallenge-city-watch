class RespondersController < ApplicationController
  before_action :page_not_found, only: [:new, :edit, :destroy]
  before_action :set_responder, only: [:show, :update]

  def create
    @responder = Responder.new(responder_params)
    if @responder.save
      render 'responders/create.json', status: :created
    else
      render 'responders/create.json', status: :unprocessable_entity
    end
  end

  def show
    if @responder
      render 'responders/show.json'
    else
      render json: nil, status: :not_found
    end
  end

  def update
    @key = set_key

    if @key == :on_duty
      @responder.update_column(:on_duty, on_duty_value)
      render 'responders/update.json'
    else
      @responder.update(responder_params)
      render 'responders/update.json', status: :unprocessable_entity
    end
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

  def set_key
    params[:responder].first[0].to_sym
  end

  def on_duty_value
    to_bool(params[:responder].fetch(:on_duty))
  end

  def to_bool(str)
    str == 'true' || str == true
  end

  def responder_params
    params.require(:responder).permit(:id, :type, :name, :capacity, :emergency_code, :on_duty)
  end
end
