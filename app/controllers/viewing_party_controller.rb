class ViewingPartyController < ApplicationController
  def conn
    Faraday.new(url: 'https://api.themoviedb.org/3/') do |faraday|
      faraday.params['api_key'] = ENV['movies_api_key']
    end
  end

  def new
    response = conn.get("movie/#{params[:movie_id]}") do |request|
      request.params['api_key'] = ENV['movies_api_key']
    end

    @movie = JSON.parse(response.body, symbolize_names: true)

    @users = User.where.not(id: params[:id])
  end

  def viewing_party_create
  end

  def create
    if !current_user.nil?
      response = conn.get("movie/#{params[:movie_id]}") do |request|
        request.params['api_key'] = ENV['movies_api_key']
      end

      @movie = JSON.parse(response.body, symbolize_names: true)

      user = User.find(params[:id])

      @viewing_party = ViewingParty.create(party_params)
      users = User.find(params[:user_ids])
      @viewing_party.user_parties.create(user: user, host: true)
      users.each do |u|
        @viewing_party.user_parties.create(user: u, host: false)
        @viewing_party.movie_title = @movie[:original_title]
        @viewing_party.poster_path = @movie[:poster_path]
      end

      if @viewing_party.save
        flash[:success] = 'Party created!'
        redirect_to '/dashboard'
      else
        flash[:alert] = 'Could not create party, please try again.'
        redirect_to "/movies/#{params[:movie_id]}/viewing-party/new"
      end
    else
        flash[:alert] = 'You must be logged in or registered to create a viewing party'
        redirect_to "/movies/#{params[:movie_id]}"
    end
  end

  private

  def party_params
    params.permit(:duration, :when, :time)
  end
end
