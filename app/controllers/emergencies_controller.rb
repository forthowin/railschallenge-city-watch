class EmergenciesController < ApplicationController
  before_action :page_not_found, only: [:new, :edit, :destroy]

  def create
    @emergency = Emergency.new(emergency_params)
    if @emergency.save
      @emergency.dispatch
      render 'emergencies/create.json', status: :created
    else
      render 'emergencies/create.json', status: :unprocessable_entity
    end
  end

  def index
    @emergencies = Emergency.all
    render 'emergencies/index.json'
  end

  def show
    @emergency = Emergency.find_by code: params[:code]
    if @emergency
      render 'emergencies/show.json'
    else
      render json: nil, status: :not_found
    end
  end

  def update
    @emergency = Emergency.find_by code: params[:code]
    if params[:emergency].include?(:code)
      render json: { message: 'found unpermitted parameter: code' }, status: :unprocessable_entity
    else
      @emergency.update(emergency_params)
      render 'emergencies/update.json'
    end
  end

  def new
  end

  def edit
  end

  def destroy
  end

  private

  def emergency_params
    params.require(:emergency).permit(:id, :resolved_at, :code, :fire_severity, :police_severity, :medical_severity)
  end
end
