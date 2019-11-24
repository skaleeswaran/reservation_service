# frozen_string_literal: true

class Api::V1::GuestsController < Api::V1::BaseController

  private

  def scope
    'Guest'.constantize
  end

  def request_params
    params.permit(:email, :phone, :first_name, :last_name)
  end

  def update_params
    request_params
  end

  def filter_params
    params.permit(:email, :phone)
  end
end
