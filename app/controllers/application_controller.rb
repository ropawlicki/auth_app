class ApplicationController < ActionController::Base
  def redirect_unauthenticated
    redirect_to signin_path unless User.find_by(id: cookies.encrypted[:user_id])
  end
end
