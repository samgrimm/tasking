require "rails_helper"

describe "add availability to users" do
  it "allows users to add availability" do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit edit_user_registration_path(user)
    fill_in 'user[availability]', with: 10
    fill_in 'user[current_password]', with: 'foobar'
    click_on 'Update'

    expect(User.last.availability).to eq(10)
  end
end
