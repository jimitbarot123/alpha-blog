class PagesController < ApplicationController
  skip_before_action :authenticate_member!, only: [:home]
  def home
    #redirect_to articles_path if member_signed_in?
  end

  def about
  end
end
