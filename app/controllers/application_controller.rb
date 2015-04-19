class ApplicationController < ActionController::Base
  def page_not_found
    render json: { message: 'page not found' }, status: :not_found
  end
end
