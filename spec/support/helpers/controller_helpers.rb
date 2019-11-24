# frozen_string_literal: true

module ControllerHelpers

  def json_response_body
    JSON.parse response.body
  end
end
