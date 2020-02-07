# frozen_string_literal: true

require 'faker'
image = %w[img_girl img_chania pic_trulli]

1.upto(20) do
  Product.create(
    title: Faker::Lorem.word,
    description: Faker::Lorem.paragraph,
    price: rand(100.00..999.99),
    image_url: "https://www.w3schools.com/html/#{image[rand(0..image.size - 1)]}.jpg"
  )
end
