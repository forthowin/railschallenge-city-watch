class EmergenciesController < ApplicationController
  before_action :page_not_found, only: [:new, :edit, :destroy]

  def create
    emergency = Emergency.new(emergency_params)
    if emergency.save
      render json: Hash['emergency', emergency].to_json, status: :created
    else
      render_json_errors(emergency)
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

  def render_json_errors(emergency)
    if emergency.errors.include?(:id)
      render_id_error
    elsif emergency.errors.include?(:resolved_at)
      render_resolved_at_error
    else
      render_errors
    end
  end

  def render_id_error
    render json: Hash['message', emergency.errors[:id].first].to_json, status: :unprocessable_entity
  end

  def render_resolved_at_error
    render json: Hash['message', emergency.errors[:resolved_at].first].to_json, status: :unprocessable_entity
  end

  def render_errors
    render json: Hash['message', emergency.errors].to_json, status: :unprocessable_entity
  end
end
