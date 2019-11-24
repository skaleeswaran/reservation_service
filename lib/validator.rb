# frozen_string_literal: true

module Validator
  NAME_REGEX = /\A[[:alpha:]\s\-'\.]+\z/.freeze
  EMAIL_REGEX = /\A[^@\s]+@[^@\s]+\z/.freeze
  PHONE_REGEX = /\A\+?([ 0-9]*)\Z/.freeze
end
