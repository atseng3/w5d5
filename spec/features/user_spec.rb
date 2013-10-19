require 'spec_helper'

describe User do
  describe "the signup process" do
    before(:each) do
      visit new_user_url
    end

    it "has a new user page" do
      expect(page).to have_content "New user"
    end

    it "takes a username and password" do
      expect(page).to have_content "Username"
      expect(page).to have_content "Password"
    end

    it "validates the presence of the user's username" do
      click_button 'Sign Up'
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Username can't be blank"
    end

    it "validates the presence of the user's password" do
      fill_in "Username", :with => "hello_world"
      click_button 'Sign Up'
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Password can't be blank"
    end

    it "validates that the password length is at least 6 characters long" do
      fill_in "Username", :with => "hello_world"
      fill_in "Password", :with => "a"
      click_button 'Sign Up'
      expect(page).to have_content "Sign Up"
      expect(page).to have_content "Password is too short"
    end

    it "has a sign out button" do
      sign_up
      expect(page).to have_button "Sign Out"
    end

    describe "signing up a user" do
      it "shows username on the homepage after signup" do
        sign_up
        expect(page).to have_content "testing_username"
      end

      it "redirects to goal page after signup" do
        sign_up
        expect(page).to have_content "Goal Setter"
      end
    end
  end

  describe "Signing out" do
    it "begins with signed out state" do
      visit user_goals_url(1)
      expect(page).to have_content "Sign In"
    end

    it "doesn't show username on the homepage after Sign Out" do
      sign_up
      click_button('Sign Out')
      expect(page).not_to have_content 'testing_username'
    end
  end
end
