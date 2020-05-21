FactoryBot.define do
  factory :test_question do
    title { "MyString" }
    content { "MyText" }
    form { 1 }
    form_size { 1 }
  end
end
