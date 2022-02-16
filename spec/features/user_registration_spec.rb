require 'rails_helper'

RSpec.describe "User Registration page", type: :feature do 

  it "has a form to register a new user" do 
    visit '/register'

    expect(page).to have_field('Name')
    expect(page).to have_field('Email')
    expect(page).to have_button('Register')

    fill_in 'Name', with: "Jeffrey Schmoe"
    fill_in 'Email', with: "jeffschmoe@mail.com"
    fill_in 'Password', with: 'test123'
    fill_in 'Password Confirmation', with: 'test123'

    click_button "Register"

    expect(current_path).to eq(user_path(User.last.id))
  end

  it "validates uniqueness of email field" do 

    user1 = User.create!(name: "Jeffrey Schmoe", email: "jeffschmoe@mail.com", password: 'test123', password_confirmation: 'test123')
    visit '/register'

    fill_in 'Name', with: "Jeffrey Schmoe"
    fill_in 'Email', with: "jeffschmoe@mail.com"
    fill_in 'Password', with: 'test123'
    fill_in 'Password Confirmation', with: 'test123'

    click_button "Register"
   
    expect(page).to have_content("jeffschmoe@mail.com has already been taken")
  end

  it 'fails to create user due to non matching passwords' do 
    visit '/register'
    fill_in 'Name', with: 'Mars Volta'
    fill_in 'Email', with: 'mvolta@mail.com'
    fill_in 'Password', with: 'music123'
    fill_in 'Password Confirmation', with: 'usic123'

    click_button 'Register'
   
    expect(page).to have_content('Password and password confirmation do not match')
  end
end
