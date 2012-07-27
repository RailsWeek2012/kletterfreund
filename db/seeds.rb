# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

eschbach = Area.create(id: 1, name: "Eschbacher Klippen", location: "Eschbacher Klippen, Usingen, Deutschland")

Route.create(id: 1, name: "Goldene Platte", directions: "Buchstein, Suedwand", grade: "V", area_id: 1, latitude: eschbach.latitude, longitude: eschbach.longitude)
Route.create(id: 2, name: "Direkte Platte", directions: "Buchstein, Suedwand", grade: "V", area_id: 1, latitude: eschbach.latitude, longitude: eschbach.longitude)
Route.create(id: 3, name: "Dach Platte", directions: "Buchstein, Suedwand", grade: "VI", area_id: 1, latitude: eschbach.latitude, longitude: eschbach.longitude)
Route.create(id: 4, name: "Quergang Nordseite", directions: "Buchstein, Nordwand", grade: "VII", area_id: 1, latitude: eschbach.latitude, longitude: eschbach.longitude)
Route.create(id: 5, name: "Schwarze Kante", directions: "Buchstein, Nordwand", grade: "VII-", area_id: 1, latitude: eschbach.latitude, longitude: eschbach.longitude)
Route.create(id: 6, name: "Geiernest", directions: "Buchstein, Suedwand", grade: "VI-", area_id: 1, latitude: eschbach.latitude, longitude: eschbach.longitude)