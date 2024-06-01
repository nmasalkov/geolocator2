require 'faker'

30.times do
  ip_address = Faker::Internet.ip_v4_address
  full_url = Faker::Internet.url
  stripped_url = URI.parse(full_url).host.gsub('www.', '')
  latitude = Faker::Number.decimal(l_digits: 4, r_digits: 4)
  longitude = Faker::Number.decimal(l_digits: 4, r_digits: 4)

  Location.create(ip_address: ip_address, url: stripped_url, latitude: latitude, longitude: longitude)
end