require 'rails_helper'

RSpec.describe 'home page', type: :feature do
  it 'has a link to return to the landing page' do
    visit ('/')
    expect(page).to have_link('Return to home')
    expect(page).to have_content('Viewing Party')
  end
  
  it 'has a create user button' do
    visit ('/')
    expect(page).to have_button('Create a New User')
    
    click_button('Create a New User')
    expect(current_path).to eq('/register')
  end
  
  it 'has links to user dashboards' do
    user1 = User.create!(name: 'Joe Schmoe', email: 'jschmoe@mail.com', password: '1234mac', password_confirmation: '1234mac')
    user2 = User.create!(name: 'Jane Schmoe', email: 'janeschmoe@mail.com', password: 'horseradish', password_confirmation: 'horseradish')
    user3 = User.create!(name: 'Moe Schmoe', email: 'moeshmoe@mail.com', password: 'remington', password_confirmation: 'remington')
    visit ('/')

    within(".existing-users") do
      expect(page).to have_link("#{user1.email}'s Dashboard")
    end
    click_link "#{user1.email}'s Dashboard"
    expect(current_path).to eq("/users/#{user1.id}")
  end
end
