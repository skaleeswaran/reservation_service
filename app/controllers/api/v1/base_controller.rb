# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  include ControllerMethods

  before_action :find_object, only: %i[show update destroy]
  before_action :initialize_object, only: [:create]
  before_action :default_format_json

  rescue_from CanCan::AccessDenied do |exception|
    fail PermissionError
  end


  private

  def default_format_json
    request.format = 'json' unless params[:format]
  end
end
