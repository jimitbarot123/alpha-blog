class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to articles_path if current_user
  end

  def about
  end
end
