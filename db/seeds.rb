# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(surname: "Мясоедов",
             firstname: "Владислав",
             middlename: "Антонович",
             passport: "1000 000000",
             password: "password",
             password_confirmation: "password",
             born_date: "2003-12-13",
             address: "Москва",
             admin: true,
             inspector: false)