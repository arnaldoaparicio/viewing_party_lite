require 'rails_helper'

RSpec.describe ViewingParty, type: :model do 

  it { should have_many(:user_parties) }
  it { should have_many(:users).through(:user_parties) }

end