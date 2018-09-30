require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryBot.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end


  describe "when signed in" do
    it "sees ratings made by them" do
      sign_in(username: "Pekka", password: "Foobar1")
      create_beer_with_rating({ user: user }, 10 )
      visit user_path(user)
      
      expect(page).to have_content 'Has given 1 rating, with an average of 10.0'
      expect(page).to have_content 'anonymous 10'
    end
    it "doesn't see ratings made by other users" do
      sign_in(username: "Pekka", password: "Foobar1")
      create_beer_with_rating({ user: FactoryBot.create(:user, username: "Vilma") }, 10 )
      visit user_path(user)
      
      expect(page).to have_content 'User has not yet rated anything!'
    end
  end

  it "after removing ratings, they are removed from database" do
    sign_in(username: "Pekka", password: "Foobar1")
    create_beer_with_rating({ user: user }, 10 )
    visit user_path(user)
    expect{
      click_link "delete"
    }.to change{Rating.count}.from(1).to(0)
  end
end