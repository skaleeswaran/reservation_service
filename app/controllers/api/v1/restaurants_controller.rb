# frozen_string_literal: true

class Api::V1::RestaurantsController < Api::V1::BaseController
  private

  def scope
    'Restaurant'.constantize
  end

  def request_params
    params.permit(:name, :phone, :email, :location, :opening_hours, cuisines: [])
  end

  def update_params
    request_params
  end

  def filter_params
    params.permit(:email, :name)
  end
end
