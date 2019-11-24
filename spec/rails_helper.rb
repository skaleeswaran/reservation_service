# frozen_string_literal: true

require 'simplecov'
require 'spec_helper'
require 'aasm/rspec'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include ControllerHelpers, type: :controller
  config.include InternalApiHelper, type: :controller
end

RSpec.configuration.mock_with(:rspec) do |config|
  config.before_verifying_doubles do |reference|
    if reference.target.is_a?(Class) && reference.target <= ActiveResource::Base
      ActiveResourceDoubleVerifier.verify(reference.target)
    end
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
