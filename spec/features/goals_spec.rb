require 'spec_helper'

describe Goals do
  describe "main page" do
    before(:each) do
      sign_up
      visit goals_url
    end

    it "shows all the goals of a user" do
      expect(page).to have_content "Goal Setter"
    end

    it "should have link to create new goal" do
      expect(page).to have_link('New Goal')
    end

  end

  describe "the process of making new goals" do
    before(:each) do
      sign_up
      visit new_goal_url
    end

    it "takes a name, type" do
      expect(page).to have_content "Name"
      expect(page).to have_content "Public"
      expect(page).to have_content "Private"
    end

    it "validates the presence of name, type" do
      click_button 'Create New Goal'
      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Goal Type can't be blank"
      end

    end

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
      visit goals_url
      expect(page).to have_content "Sign In"
    end

    it "doesn't show username on the homepage after Sign Out" do
      sign_up
      click_button('Sign Out')
      expect(page).not_to have_content 'testing_username'
    end
  end
end
