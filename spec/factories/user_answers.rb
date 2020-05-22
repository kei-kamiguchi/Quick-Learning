FactoryBot.define do
  factory :user_answer do
    user_id { 1 }
    test_question_id { 1 }
    answer { "MyText" }
  end
end
