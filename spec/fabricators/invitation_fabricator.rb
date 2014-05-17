Fabricator(:invitation) do
  recipiant_email { Faker::Internet.email.to_s }
  recipiant_name { Faker::Name.name.to_s }
  message { Faker::Lorem.paragraph(3).to_s }
end