# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

3.times do |index|
  User.create(
    name: Faker::Name.first_name,
    email: "liss_#{index}@fbot.bcom",
    provider: 'github',
    uid: Faker::Alphanumeric.alpha(10)
  )
  puts "#{index + 1} users created"

  MyPoll.create(title: Faker::Lorem.sentence,
                description: Faker::Lorem.sentences,
                expires_at: DateTime.now + 1.year,
                user: User.last
  )

  Question.create(description: '¿Cuál es tu personaje favorito en Marvel?' + Faker::Book.genre,
                  my_poll: MyPoll.last
  )

  Answer.create(description: Faker::Movie.quote,
                question: Question.last
  )
end

