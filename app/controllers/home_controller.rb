class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:main]

  def index
    redirect_to home_main_path if current_user
  end

  def main
  end
end
