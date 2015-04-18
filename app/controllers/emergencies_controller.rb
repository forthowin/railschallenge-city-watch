class EmergenciesController < ApplicationController
  before_action :page_not_found, only: [:new, :edit, :destroy]

  def create
    emergency = Emergency.new(emergency_params)
    if emergency.save
      render json: Hash['emergency', emergency].to_json, status: :created
    else
      render json: emergency.error_message.to_json, status: :unprocessable_entity
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

  def page_not_found
    render json: Hash['message', 'page not found'].to_json, status: :not_found
  end
end
