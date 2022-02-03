require 'rails_helper'

RSpec.describe "New Viewing Party page", type: :feature do 

  describe "the form" do 

    it "has pre-filled duration default to movie runtime in minutes" do 

    user1 = User.create!(name: "Joe Schmoe", email: "joeschmoe@mail.com")
    user2 = User.create!(name: "Jeffrey Schmoe", email: "jeffschmoe@mail.com")
    user3 = User.create!(name: "Jamie Schmoe", email: "jamieschmoe@mail.com")

    visit "/users/#{user1.id}/movies/497698/viewing-party/new"

    expect(page).to have_field("Duration", with: 134)
    expect(page).to have_field("When")
    expect(page).to have_field("Start Time")
    expect(page).to have_content("Invite Users to Your Viewing Party")
    expect(page).to have_button("Create Party")
    end
    
  end

end
