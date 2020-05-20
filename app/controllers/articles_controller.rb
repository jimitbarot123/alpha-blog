class ArticlesController < ApplicationController
  load_and_authorize_resource
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  #before_action :require_user#, except: [:index, :show]
  #before_action :require_same_user, only: [:edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created successfully."
      #redirect_to @article #article_patch(@article)
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully."
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article was deleted successfully."
      redirect_to articles_path
    end
  end

  protected

    def resource_not_found
      message = "The article you are looking for could not be found"
      flash[:alert] = message
      redirect_to root_path
    end

 private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

end
