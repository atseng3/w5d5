require 'spec_helper'

describe Goal do
  describe "on the other user's goal page" do
    before(:each) do
      sign_up
      make_public_goal
      make_private_goal
      click_button "Sign Out"
      sign_up_as_helloworld
      visit '/users/1/goals'
    end

    it "shows only public goals of testing_username" do
      expect(page).to have_content "whatever you want"
      expect(page).not_to have_content "whatever private wants"
    end
  end

  describe "on user's goal page" do
    before(:each) do
      sign_up

    end

    it "shows all the goals of a specific user" do
      expect(page).to have_content "My Goals"
    end

    it "should have link to create new goal" do
      expect(page).to have_link('New Goal')
    end
  end

  describe "the process of making new goals" do
    before(:each) do
      sign_up
      click_link "New Goal"
    end

    it "takes a name, type" do
      expect(page).to have_content "Name"
      expect(page).to have_content "public"
      expect(page).to have_content "private"
    end

    it "validates the presence of name, type" do
      click_button 'Create New Goal'
      expect(page).to have_content "Name can't be blank"
      expect(page).to have_content "Goal type can't be blank"
    end

    it "shows goal info on the user's show page after creating goal" do
      make_public_goal
      expect(page).to have_content "whatever you want"
      expect(page).to have_content "testing_username"
      expect(page).to have_content "INCOMPLETE"
    end

  end

  describe "the process of editing a goal" do
    before(:each) do
      sign_up
      click_link ("New Goal")
      make_public_goal
      click_link ("whatever you want")
    end

    it "shows name, type all filled in" do
      expect(page).to have_content "whatever you want"
    end

    it "shows changes made to a goal" do
      choose('Private')
      click_button("Edit Goal")
      expect(page).to have_content "private"
    end

    it "shows changes made to a goal" do
      choose('Complete')
      click_button("Edit Goal")
      expect(page).to have_content "COMPLETE"
    end
  end

  describe "the process of deleting a goal" do
    before(:each) do
      sign_up
      click_link ("New Goal")
      make_public_goal
    end

    it "removes the goal from user's show page" do
      click_button "Delete Goal"
      expect(page).not_to have_content "whatever you want"
    end
  end
end