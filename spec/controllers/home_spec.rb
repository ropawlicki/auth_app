require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    it 'redirects to signin path if encrypted cookie with user id is not present' do
      user = create(:user)
      cookies.encrypted.permanent[:user_id] = user.id + 1
      get :index

      expect(response).to redirect_to(signin_path)
    end
  end
end
