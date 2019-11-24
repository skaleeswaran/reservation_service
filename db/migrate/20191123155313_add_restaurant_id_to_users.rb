class AddRestaurantIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :restaurant_id, :bigint
  end
end
