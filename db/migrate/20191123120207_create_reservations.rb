# frozen_string_literal: true

class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.string :status
      t.datetime :start_time
      t.integer :covers
      t.text :notes
      t.bigint :guest_id
      t.bigint :restaurant_id
      t.timestamps
    end
  end
end
