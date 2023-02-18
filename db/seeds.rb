# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# User.destroy_all
# UserExchange.destroy_all
# Exchange.destroy_all
# UserReview.destroy_all
# Review.destroy_all

faiz = User.create(username: "faiz", password: "Faiz.3", email: "faiz@gmail.com", address: "100-19 5th St",
state: "New York", zipcode: "11322", lat: 40.7052878, lng: -74.013904)


alex = User.create(username: "alex", password: "alex.2", email: "alex@gmail.com", address: "101-19 8th St",
state: "New York", zipcode: "11922", lat: 40.7527277, lng: -73.97723529999999)

faiz_alex_exchange = Exchange.create(invite_code: 1234, address_1: "100-19 5th St New York 
11322", address_1_lat: faiz.lat, address_1_lng: faiz.lng, address_2: "101-19 8th St New York 11922", address_2_lat: alex.lat,
address_2_lng: alex.lng, meeting_address: "112-34, 140th ST Ny 22430", meeting_address_lat: 230, meeting_address_lng: 304)

UserExchange.create(user_id: faiz.id, exchange_id: faiz_alex_exchange.id)
UserExchange.create(user_id: alex.id, exchange_id: faiz_alex_exchange.id)

review1 = Review.create(reviewer_id: alex.id, reviewed_id: faiz.id, exchange_id: faiz_alex_exchange.id, rating: 5,
content: "Faiz the goat")

review2 = Review.create(reviewer_id: faiz.id, reviewed_id: alex.id, exchange_id: faiz_alex_exchange.id, rating: 5,
content: "Alex the goat")

UserReview.create(user_id: faiz.id, review_id: review1.id)
UserReview.create(user_id: alex.id, review_id: review2.id)
# faiz_alex_chat = Chat.create(message: "YOooooo", user_id:alex.id,exchange_id:faiz_alex_exchange.id)
