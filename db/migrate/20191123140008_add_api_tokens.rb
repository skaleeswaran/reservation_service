# frozen_string_literal: true

class AddApiTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :api_token, :string
  end
end
