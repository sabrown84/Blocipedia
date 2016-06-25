require 'rails_helper'
include Devise::TestHelpers

RSpec.describe WikisController, type: :controller do
  before do
    @user = create(:user)
    sign_in @user
  end

  let(:my_wiki) { create :wiki }
  let(:my_private_wiki) { create(:wiki, private: true) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end

    it "does not include private wikis in @wikis" do
      get :index
      expect(assigns(:wikis)).not_to include(my_private_wiki)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end

    it "redirects from private wikis" do
      get :show, id: my_private_wiki.id
      expect(response).to redirect_to wikis_path
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
    it "deletes the wiki" do
      delete :destroy, id: my_wiki.id
      count = Wiki.where(id: my_wiki.id).size
      expect(count).to eq 0
    end

    it "redirects to wikis index" do
      delete :destroy, id: my_wiki.id
      expect(response).to redirect_to wikis_path
    end
  end
end
