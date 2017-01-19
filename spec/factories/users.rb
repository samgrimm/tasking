FactoryGirl.define do

    sequence :email do |n|
      "test#{n}@example.com"
    end

    factory :user do
      email { generate :email }
      password "foobar"
      password_confirmation "foobar"
      availability 8
    end

end
