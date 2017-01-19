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

    factory :client, class: "Client" do
      email "client@user.com"
      password "foobar"
      password_confirmation "foobar"
    end

end
