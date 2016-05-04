class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @wikis = Wiki.visible_to(current_user)
    authorize @wikis
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to edit_wiki_path(@wiki)
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

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
     authorize @wiki

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
