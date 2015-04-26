class ApplicationController < ActionController::Base
  rescue_from ActionController::UnpermittedParameters, with: :unpermitted_param_errors

  private

  def action_missing(m)
    Rails.logger.error(m)
    render json: { message: 'page not found' }, status: :not_found
  end

  def unpermitted_param_errors
    render json: { message: $ERROR_INFO.message }, status: :unprocessable_entity
  end
end
