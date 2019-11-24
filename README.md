<p> This app demostrates a basic restaurant management system </p>

<p> Steps to use this app <p>
1) Clone the app
2) bundle install
3) Change database.yml to modify username and password for the database
4) rake db:create
5) rake db:migrate
6) rake db:seed
7) bundle exec rspec spec - To run unit tests

<a href="https://www.getpostman.com/collections/d41ff11fbde62b07fd06"> Postman API collection </a>

By default - an admin user, a restaurant and a restaurant user are pre-populated using seeds. The API tokens for the two users are also created. They will be present in the users table.
The Postman API collection has three folders - one per user. In each folder, you can click on Edit -> Authorization -> modify the API token you fetch from the users table (depending on the type of user).

Few scenarios:
1) When an Admin user is creating reservation, they need to pass in both guest_id and restaurant_id
2) When Guest is creating reservation, they need to pass in only restaurant_id. Guest will be able to fetch only reservations done by them.
3) When Restaurant user is creating reservation, they need to pass in only guest_id. Restaurant user will be able to fetch only reservations in the restaurant they belong to.
4) Guest user will be able to do GET all restaurants
5) Restaurant user will be able to do GET all guests and restaurants

Notes:
1) Reservations also has a "created_by" column indicating the user who created them.

Things to be implemented:
- Haven’t included pagination yet
- Move api tokens out of users model and have an API gateway manage it
- Maintain a list of cuisines and let the Restaurant API choose only from it
- Could have done access control via gems (like cancan, pundit)
