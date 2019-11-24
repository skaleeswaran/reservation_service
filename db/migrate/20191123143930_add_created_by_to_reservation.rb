class AddCreatedByToReservation < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :created_by, :bigint
  end
end
