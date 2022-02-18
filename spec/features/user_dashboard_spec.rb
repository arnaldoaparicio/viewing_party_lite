require 'rails_helper'

RSpec.describe 'User Dashboard Page', type: :feature do
  describe 'top title and navigation links' do
    it 'should have the user name in heading + button to go to the discover movies page' do
      user1 = User.create!(name: 'Joe Schmoe', email: 'joeschmoe@mail.com', password: '1234mac',
                           password_confirmation: '1234mac')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      expect(page).to have_content("#{user1.name}'s Dashboard")

      within '.movie-discovery' do
        expect(page).to have_button('Discover Movies')

        click_button 'Discover Movies'
      end

      expect(current_path).to eq('/discover')
    end
  end

  describe 'Viewing Parties section' do
    it 'should have all the viewing parties that the user has been invited to' do
      user1 = User.create!(name: 'Joe Schmoe', email: 'joeschmoe@mail.com', password: '1234mac',
                           password_confirmation: '1234mac')
      user2 = User.create!(name: 'Jeffrey Schmoe', email: 'jeffschmoe@mail.com', password: 'generic123',
                           password_confirmation: 'generic123')
      user3 = User.create!(name: 'Moe Schmoe', email: 'moeschmoe@mail.com', password: 'scarymovie',
                           password_confirmation: 'scarymovie')

      party1 = ViewingParty.create!(duration: 184, when: '2023/02/07', time: '9:00pm', movie_title: 'Black Widow',
                                    poster_path: '/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg')

      user_party1 = party1.user_parties.create!(user_id: user1.id, viewing_party_id: party1.id, host: true)
      user_party2 = party1.user_parties.create!(user_id: user2.id, viewing_party_id: party1.id, host: false)
      user_party3 = party1.user_parties.create!(user_id: user3.id, viewing_party_id: party1.id, host: false)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user3)
      visit '/dashboard'

      within '.viewing-parties' do
        expect(page).to have_css("img[src*='/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg']")
        expect(page).to have_content(party1.movie_title)
        expect(page).to have_content(party1.when)
        expect(page).to have_content(party1.time)
        expect(page).to have_content('Invited')
      end
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

      visit '/dashboard'

      within '.viewing-parties' do
        expect(page).to have_css("img[src*='/qAZ0pzat24kLdO3o8ejmbLxyOac.jpg']")
        expect(page).to have_content(party1.movie_title)
        expect(page).to have_content(party1.when)
        expect(page).to have_content(party1.time)
        expect(page).to have_content('Hosting')
      end
    end
  end
end
