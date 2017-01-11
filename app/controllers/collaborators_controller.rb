class CollaboratorsController < ApplicationController
  def index
    @collaborators = Collaborator.all
    @wiki = Wiki.find(params[:wiki_id])
  end

  def new
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.new
  end

  def create
    @wiki = Wiki.find(params[:wiki_id])
    user = User.find(params[:user_id])

    if @wiki.collaborators.include?(user)
      flash[:alert] = "#{user.email} is already a collaborator"
    else
      collaborator = Collaborator.new(user: user, wiki: @wiki)
      if collaborator.save
        flash[:notice] = "#{user.email} is now a collaborator on this wiki."
        redirect_to wiki_path(@wiki)
      else
        flash[:alert] = "Something wrong, please try again"
        render :new
      end
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.users.find(params[:user_id])

    if @collaborator.destroy
      flash[:notice] = "#{@collaborator.email} was deleted"
      redirect_to wiki_path(@wiki)
    else
      flash[:alert] = "#{@collaborator.email} couldn't be deleted. Try again."
      redirect_to :back
    end
  end
end
