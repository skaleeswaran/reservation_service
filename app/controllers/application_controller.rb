# frozen_string_literal: true

class ApplicationController < ActionController::API

  include ApiErrorHandling

  before_action :authorize_user
  before_action :authorize_resource!

  def authorize_user
    @current_user ||= begin
      request.headers['Authorization'] && request.headers['Authorization'].match(/Bearer (\S+)/) do |m|
        User.find_by(api_token: m[1])
      end or fail PermissionError
    end
  end

  def authorize_resource!
    if current_user.is_a?(RestaurantUser) or current_user.is_a?(Guest)
      return true if params[:controller].include?("reservation")
      return true if params[:controller].include?("restaurant") && params[:action].include?("index")
      return true if current_user.is_a?(RestaurantUser) && params[:controller].include?("guest") && params[:action].include?("index")
      fail PermissionError 
    end
    true
  end

  def current_user 
    @current_user
  end
end
