

class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  #before_action :authorize_user, except: [:show, :new, :create]
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  # GET /wikis
  def index
    @wikis = Wiki.all
  end

  # GET /wikis/1
  def show
  end

  # GET /wikis/new
  def new
    @wiki = Wiki.new
  end

  # GET /wikis/1/edit
  def edit
  end

  # POST /wikis
  def create
    @wiki = Wiki.new(wiki_params)

    if @wiki.save
      redirect_to @wiki, notice: 'Wiki was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /wikis/1
  def update
    if @wiki.update(wiki_params)
      redirect_to @wiki, notice: 'Wiki was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /wikis/1
  def destroy
    @wiki.destroy
    redirect_to wikis_url, notice: 'Wiki was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def wiki_params
      params.require(:wiki).permit(:title, :body, :private, :user_id)
    end

    def authorize_user
      wiki = Wiki.find(params[:id])
      unless current_user == wiki.user || current_user.admin?
        flash[:alert] = "You must be an admin to do that."
        redirect_to [wiki, wiki]
      end
    end
end
