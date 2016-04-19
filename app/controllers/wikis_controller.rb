class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = Wiki.visible_to(current_user)
  end

  def show
    @wiki = Wiki.find(params[:id])

    unless @wiki.public || current_user
      flash[:alert] = "You must be signed in to view private wikis."
      redirect_to new_session_path
    end
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)

    if @wiki.save
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

   def destroy
     @wiki = Wiki.find(params[:id])
     title = @wiki.title

     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
     end
   end

   private

   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end
end
