Fabricator(:user) do
  fullname { Faker::Name.name.to_s }
  email { Faker::Internet.email.to_s }
  password 'password'
end