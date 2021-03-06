require 'rails_helper'


RSpec.describe WikisController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Wiki. As you add validations to Wiki, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # WikisController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all wikis as @wikis" do
      wiki = Wiki.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:wikis)).to eq([wiki])
    end
  end

  describe "GET #show" do
    it "assigns the requested wiki as @wiki" do
      wiki = Wiki.create! valid_attributes
      get :show, params: {id: wiki.to_param}, session: valid_session
      expect(assigns(:wiki)).to eq(wiki)
    end
  end

  describe "GET #new" do
    it "assigns a new wiki as @wiki" do
      get :new, params: {}, session: valid_session
      expect(assigns(:wiki)).to be_a_new(Wiki)
    end
  end

  describe "GET #edit" do
    it "assigns the requested wiki as @wiki" do
      wiki = Wiki.create! valid_attributes
      get :edit, params: {id: wiki.to_param}, session: valid_session
      expect(assigns(:wiki)).to eq(wiki)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Wiki" do
        expect {
          post :create, params: {wiki: valid_attributes}, session: valid_session
        }.to change(Wiki, :count).by(1)
      end

      it "assigns a newly created wiki as @wiki" do
        post :create, params: {wiki: valid_attributes}, session: valid_session
        expect(assigns(:wiki)).to be_a(Wiki)
        expect(assigns(:wiki)).to be_persisted
      end

      it "redirects to the created wiki" do
        post :create, params: {wiki: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Wiki.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved wiki as @wiki" do
        post :create, params: {wiki: invalid_attributes}, session: valid_session
        expect(assigns(:wiki)).to be_a_new(Wiki)
      end

      it "re-renders the 'new' template" do
        post :create, params: {wiki: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, params: {id: wiki.to_param, wiki: new_attributes}, session: valid_session
        wiki.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested wiki as @wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, params: {id: wiki.to_param, wiki: valid_attributes}, session: valid_session
        expect(assigns(:wiki)).to eq(wiki)
      end

      it "redirects to the wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, params: {id: wiki.to_param, wiki: valid_attributes}, session: valid_session
        expect(response).to redirect_to(wiki)
      end
    end

    context "with invalid params" do
      it "assigns the wiki as @wiki" do
        wiki = Wiki.create! valid_attributes
        put :update, params: {id: wiki.to_param, wiki: invalid_attributes}, session: valid_session
        expect(assigns(:wiki)).to eq(wiki)
      end

      it "re-renders the 'edit' template" do
        wiki = Wiki.create! valid_attributes
        put :update, params: {id: wiki.to_param, wiki: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested wiki" do
      wiki = Wiki.create! valid_attributes
      expect {
        delete :destroy, params: {id: wiki.to_param}, session: valid_session
      }.to change(Wiki, :count).by(-1)
    end

    it "redirects to the wikis list" do
      wiki = Wiki.create! valid_attributes
      delete :destroy, params: {id: wiki.to_param}, session: valid_session
      expect(response).to redirect_to(wikis_url)
    end
  end

end
