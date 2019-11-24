# frozen_string_literal: true

admin = Admin.create!(first_name: 'Admin', last_name: 'admin', email: 'admin@admin.com', api_token: SecureRandom.uuid)
restaurant = Restaurant.create!(name: "Sample Restaurant", email: "abc@abc.com", phone: "994534545", location: "Dubai",opening_hours: "09.00AM", cuisines: ["Asian"])
restaurant_user = RestaurantUser.create!(first_name: 'restaurant', last_name: 'user', email: 'restaurant_user@user.com', api_token: SecureRandom.uuid, restaurant_id: restaurant.id)
