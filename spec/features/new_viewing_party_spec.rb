require 'rails_helper'

RSpec.describe "New Viewing Party page", type: :feature do 

  describe "the form" do 

    xit "creates a new viewing-party with prefilled and input data" do 

      user1 = User.create!(name: "Joe Schmoe", email: "joeschmoe@mail.com")
      user2 = User.create!(name: "Jeffrey Schmoe", email: "jeffschmoe@mail.com")
      user3 = User.create!(name: "Jamie Schmoe", email: "jamieschmoe@mail.com")

      visit "/users/#{user1.id}/movies/497698/viewing-party/new"

      expect(page).to have_field("Duration", with: 134)
      expect(page).to have_field("When")
      expect(page).to have_field("Start Time")
      expect(page).to have_content("Invite Users to Your Viewing Party")
      expect(page).to have_button("Create Party")
      
      #fill in "when" date with tomorrow
      page.find('#when').set(Time.now + 1.day)
      fill_in :time, with: "8:00 pm"

      page.check("Jeffrey Schmoe")
      page.check("Jamie Schmoe")

      click_button "Create Party"

      expect(current_path).to eq("/users/#{user1.id}")
      expect(page).to have_content("Party created!")
      expect(page).to have_content("Black Widow")
      expect(page).to have_content(Time.now + 1.day)
      expect(page).to have_content("8:00 pm")
    end

  end

end
