require 'rails_helper'

RSpec.describe 'movies results page', type: :feature do

  describe 'user requests top rated movies' do

    it "displays top rated movies" do
      VCR.use_cassette('movie_db_discover_top_rated') do
        
        user1 = User.create!(name: 'Joe Schmoe', email: 'jschmoe1@mail.com', password: '1234mac', password_confirmation: '1234mac')

        visit("/users/#{user1.id}/discover")

        click_button 'Find Top Rated Movies'
        
        expect(page).to have_css('.movie', count: 40)

        within(first('.movie')) do
          expect(page).to have_css('.original_title')
          expect(page).to have_css('.vote_average')
        end
      end
    end

  end

  describe 'user searches for movies' do

    it "displays searched movies" do
      VCR.use_cassette('movie_db_discover_search') do
        
        user1 = User.create!(name: 'Joe Schmoe', email: 'jschmoe1@mail.com', password: '1234mac', password_confirmation: '1234mac')
        visit("/users/#{user1.id}/discover")

        fill_in :query, with: "Phoenix"

        click_button 'Find Movies'
        
        within(first('.movie')) do
          expect(page).to have_css('.original_title')
          expect(page).to have_css('.vote_average')
        end
      end
    end
    
  end
end
