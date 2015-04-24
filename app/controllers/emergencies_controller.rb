class EmergenciesController < ApplicationController
  before_action :page_not_found, only: [:new, :edit, :destroy]
  before_action :set_emergency, only: [:show, :update]

  def create
    @emergency = Emergency.new(emergency_create_params)
    if @emergency.save
      @emergency.dispatch
      render 'emergencies/create', status: :created
    else
      render 'emergencies/create', status: :unprocessable_entity
    end
    rescue ActionController::UnpermittedParameters => e
      render json: { message: e.message }, status: :unprocessable_entity
  end

  def index
    @emergencies = Emergency.all
    render 'emergencies/index'
  end

  def show
    if @emergency
      render 'emergencies/show'
    else
      render json: nil, status: :not_found
    end
  end

  def update
    @emergency.update(emergency_update_params)
    @emergency.clear_responders_emergency_code if params[:emergency].include?(:resolved_at)
    render 'emergencies/update'
    rescue ActionController::UnpermittedParameters => e
      render json: { message: e.message }, status: :unprocessable_entity
  end

  def new
  end

  def edit
  end

  def destroy
  end

  private

  def emergency_update_params
    params.require(:emergency).permit(:resolved_at, :fire_severity, :police_severity, :medical_severity)
  end

  def set_emergency
    @emergency = Emergency.find_by code: params[:id]
  end

  def emergency_create_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end
