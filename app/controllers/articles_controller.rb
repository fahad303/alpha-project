class ArticlesController < ApplicationController
   
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user,  only: [:edit, :update, :destroy]
   def index
      @articles = Article.where(["title LIKE?", "%#{params[:search]}%"]).paginate(page: params[:page], per_page:5) 
   end
   
   def new
    @article = Article.new
   end
   
   def create

    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
        flash[:success] = "The article successfully created"
        redirect_to article_path(@article)
    else
        render 'new'
    end
   end
   
   def destroy
      @article = Article.find(params[:id])
      @article.destroy
      flash[:danger] = "The Article successfully Deleted"
      redirect_to articles_path(@article)
   end
   
   def show
       @article = Article.find(params[:id])
   end
   
   def edit
      @article = Article.find(params[:id]) 
   end
   
   def update
      @article = Article.find(params[:id])
      if @article.update(article_params)
            flash[:success] = "The article successfully updated"
            redirect_to article_path(@article)
      else
          render 'edit'
      end
   end
   
   def set_article
       @article = Article.find(params[:id])
   end
   
   def require_same_user
      if current_user != @article.user and !current_user.admin?
          flash[:danger] = "You don't Access the others articles"
          redirect_to root_path
      end
   end
   
   private
        def article_params
           params.require(:article).permit(:title, :description, category_ids: []) 
        end
        
    
end