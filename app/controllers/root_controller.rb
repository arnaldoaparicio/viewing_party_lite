class RootController < ApplicationController
  def index
    @users = User.all
  end

end
