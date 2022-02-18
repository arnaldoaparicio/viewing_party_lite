require 'faraday'

class MoviesController < ApplicationController

  def results
    @m_data = MovieFacade.details(params[:query])
    @user = User.find(current_user.id)
    render '/users/movies'
  end

  def details
    # @user = User.find(current_user.id)
    @movie = MovieFacade.movie_data(params[:movie_id])
    @credits = MovieFacade.credits(params[:movie_id])
    @movie_reviews = MovieFacade.reviews(params[:movie_id])
    
    render '/users/details'
  end
end
