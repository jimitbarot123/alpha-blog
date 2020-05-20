class ApplicationController < ActionController::Base

  before_action :authenticate_user!
  include DeviseWhitelist

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found

  protected

  def resource_not_found
  end

end
