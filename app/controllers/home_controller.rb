class HomeController < ApplicationController
  before_action :redirect_unauthenticated

  def index; end
end
