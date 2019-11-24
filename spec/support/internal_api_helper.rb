# frozen_string_literal: true

module InternalApiHelper
  module_function

  def auth_login(api_key)
    @request.env['HTTP_ACCEPT'] = 'application/json'
    request.env['HTTP_AUTHORIZATION'] = "Bearer #{api_key}"
  end
end
