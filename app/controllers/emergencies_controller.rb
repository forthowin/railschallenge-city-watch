class EmergenciesController < ApplicationController

  def create
    emergency = Emergency.new(emergency_params)
    emergency.save
    binding.pry
    render json: Hash['emergency', emergency].to_json
  end
  def new
    ActionController::RoutingError.new('page not found')
  end
  def edit
    raise ActionController::RoutingError.new('page not found')
  end
  def destroy
    raise ActionController::RoutingError.new('page not found')
  end

  private

  def emergency_params
    params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
  end
end