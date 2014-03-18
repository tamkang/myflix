Fabricator(:video) do
  title { Faker::Lorem.words(5).to_s }
  description { Faker::Lorem.paragraph(3).to_s }	
end