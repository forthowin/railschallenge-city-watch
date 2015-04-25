class ApplicationController < ActionController::Base
  before_action :page_not_found, only: [:new, :edit, :destroy]

  rescue_from ActionController::UnpermittedParameters, with: :unpermitted_param_errors

  def page_not_found
    render json: { message: 'page not found' }, status: :not_found
  end

  def unpermitted_param_errors
    render json: { message: $!.message }, status: :unprocessable_entity
  end
end
