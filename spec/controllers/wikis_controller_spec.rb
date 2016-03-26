require 'rails_helper'
require 'random_data'

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "DELETE destroy" do
     it "deletes the wiki" do
       delete :destroy, {id: my_wiki.id}
       count = Wiki.where({id: my_wiki.id}).size
       expect(count).to eq 0
     end

     it "redirects to wikis index" do
       delete :destroy, {id: my_wiki.id}
       expect(response).to redirect_to wikis_path
     end
   end
end
