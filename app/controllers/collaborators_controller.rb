class CollaboratorsController < ApplicationController
  def new
    @collaborator = Collaborator.new
    @user = User.all
    @wiki = Wiki.find(params[:wiki_id])
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.where(email: params[:email]).take
    if @user == nil?
      flash[:error] = "Collaborator could not be found."
    else
      collaborator = @wiki.collaborators.build(user_id: @user.id)
      if collaborator.save
        flash[:notice] = "Your collaborator has been added to the wiki."
      else
        flash[:error] = "Collaborator could not be added. Check spelling."
      end
      redirect_to edit_wiki_path(@wiki)
    end
  end

  def show
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    @wiki = @collaborator.wiki
    if @collaborator.destroy
      flash[:notice] = "Collaborator removed from wiki."
    else
      flash[:error] = "Collaborator could not be removed."
    end
    redirect_to edit_wiki_path(@wiki)
  end
end
