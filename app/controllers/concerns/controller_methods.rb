# frozen_string_literal: true

module ControllerMethods
  def index
    show_response(current_objects)
  end

  def show
    show_response(@current_object)
  end

  def create
    @current_object.save!
    show_response(@current_object)
  end

  def update
    @current_object.update!(update_params)
    show_response(@current_object)
  end

  def destroy
    @current_object.destroy
  end

  private

  def find_object
    @current_object ||= scope.find_by(id: params[:id])
  end

  def current_objects
    @current_objects ||= scope.where(filter_params.to_h.symbolize_keys)
  end

  def initialize_object
    @current_object ||= scope.new(request_params)
  end

  def show_response(resource, status = :ok)
    render json: resource.to_json, status: status
  end
end
