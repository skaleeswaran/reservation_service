# frozen_string_literal: true

class Api::V1::ReservationsController < Api::V1::BaseController

  private

  def initialize_object
    @current_object ||= Reservation.new(request_params)
    @current_object.guest_id = current_user.id if current_user.is_a?(Guest) #self service creation
    @current_object.restaurant_id = current_user.restaurant_id if current_user.is_a?(RestaurantUser)
    @current_object.created_by = current_user.id
    @current_object
  end

  def scope
    if current_user.is_a?(Guest)
      Reservation.where(guest_id: current_user.id)
    elsif current_user.is_a?(RestaurantUser)
      Reservation.where(restaurant_id: current_user.restaurant_id)
    else
      Reservation.all
    end
  end
  
  def request_params
    params.permit(:start_time, :covers, :notes, :status, :guest_id, :restaurant_id)
  end

  def update_params
    params.permit(:start_time, :covers, :notes, :status)
  end

  def filter_params
    params.permit(:guest_id, :restaurant_id)
  end
end
