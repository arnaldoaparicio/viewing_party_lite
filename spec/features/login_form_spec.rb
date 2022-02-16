require 'rails_helper'

RSpec.describe 'Viewing Party User Login Form' do
  it 'successfully logs in user' do
    user1 = User.create!(name: "Jeffrey Schmoe", email: "jeffschmoe@mail.com", password: 'test123', password_confirmation: 'test123')

    visit '/login'
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Login')

    fill_in 'Email', with: 'jeffschmoe@mail.com'
    fill_in 'Password', with: 'test123'

    click_button 'Login'
    expect(current_path).to eq(user_path(user1))
  end

  it 'unsuccessfully logs in user' do
    user1 = User.create!(name: "Jeffrey Schmoe", email: "jeffschmoe@mail.com", password: 'test123', password_confirmation: 'test123')

    visit '/login'
    expect(page).to have_field('Email')
    expect(page).to have_field('Password')
    expect(page).to have_button('Login')

    fill_in 'Email', with: 'jeffschmoe@mail.com'
    fill_in 'Password', with: 'test1'
    click_button 'Login'
    
    expect(current_path).to eq('/login')
    expect(page).to have_content('Sorry, your credentials are bad.')
  end
end
