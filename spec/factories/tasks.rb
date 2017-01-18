FactoryGirl.define do
  factory :task do
    estimated_start_date "2017-01-17"
    project nil
    duration "9.99"
    name "MyString"
    status 1
  end
end
