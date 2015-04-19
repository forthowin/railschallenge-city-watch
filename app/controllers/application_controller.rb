class ApplicationController < ActionController::Base
  def page_not_found
    render json: Hash['message', 'page not found'].to_json, status: :not_found
  end
end
