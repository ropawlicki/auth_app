require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST create' do
    before(:each) do
      @password = '123456'
      @user = create(:user, password: @password)
    end

    context 'when provided with existing username' do
      before(:each) do
        @params = { 'username' => @user.username }
      end

      it 'redirects to signin path displays warning message if failed signin attempts equals 3' do
        @user.update(failed_signin_attempts: 3)
        post :create, params: @params

        expect(response).to redirect_to(signin_path)
        expect(flash[:warning]).to eq 'Too many sign in attempts. Account blocked.'
      end

      context 'and valid password' do
        before(:each) do
          @params['password'] = @password
        end

        it 'redirects to home index' do
          post :create, params: @params

          expect(response).to redirect_to(index_path)
        end

        it 'resets failed signin attempts counter' do
          @user.update(failed_signin_attempts: 1)
          post :create, params: @params
          updated_user = User.find(@user.id)

          expect(updated_user.failed_signin_attempts).to eq 0
        end
      end

      context 'and invalid password' do
        before(:each) do
          @params['password'] = "#{@password}01"
        end

        it 'redirects to signin' do
          post :create, params: @valid_params

          expect(response).to redirect_to(signin_path)
        end

        it 'increments failed signin attempts counter by 1' do
          post :create, params: @params
          updated_user = User.find(@user.id)

          expect(updated_user.failed_signin_attempts).to eq @user.failed_signin_attempts + 1
        end
      end
    end

    context 'when provided with non existent username' do
      it 'redirects to signin' do
        post :create

        expect(response).to redirect_to(signin_path)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'redirects to signin path' do
      delete :destroy

      expect(response).to redirect_to(signin_path)
    end
  end
end
