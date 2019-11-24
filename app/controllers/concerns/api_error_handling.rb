# frozen_string_literal: true

# custom error classes
# Same used in sandbox
class PermissionError < StandardError; end

module ApiErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing,    with: :parameters_invalid_err
    rescue_from ActiveRecord::RecordInvalid,           with: :record_invalid
    rescue_from ActiveRecord::RecordNotFound,          with: :not_found
    rescue_from ActiveModel::ForbiddenAttributesError, with: :parameters_invalid
    rescue_from PermissionError,                       with: :permissions_invalid
  end

  private

  def error_response(message, code, errors = [])
    {
      error: {
        message: message || '',
        code: code || 0,
        errors: errors || []
      }
    }
  end

  def parameters_invalid_err(exception)
    render json: error_response(exception.to_s, 400), status: 400
  end

  def record_invalid(_exception)
    errors = @current_object.errors.map do |attribute, error|
      { field: attribute, message: error }
    end

    render json: error_response('validation failed', 400, errors), status: 400
  end

  def parameters_invalid(_exception)
    render json: error_response('invalid parameters present', 400), status: 400
  end

  def permissions_invalid(_exception)
    render json: error_response('no permissions to access endpoint', 403), status: 403
  end

  def not_found(_exception)
    render json: error_response('not found', 404), status: 404
  end

  def server_error(_exception)
    render json: error_response('internal server error', 500), status: 500
  end
end
