Fabricator(:category) do
  title { Faker::Lorem.words(5).to_s }
  description { "hello" }
end