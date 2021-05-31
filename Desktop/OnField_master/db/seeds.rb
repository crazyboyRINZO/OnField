# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Post.create!(title: 'test', sports: 'サッカー', match: '練習試合', area: '神奈川県', start_time: '2000-01-01 00:00', match_start: '2000-01-01 00:00:00')
Post.create!(title: 'test', sports: 'フットサル', match: '本番試合', area: '東京都', start_time: '2000-01-01 00:00', match_start: '2000-01-01 00:00:00')