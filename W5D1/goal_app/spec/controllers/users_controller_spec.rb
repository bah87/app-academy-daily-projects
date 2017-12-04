require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success and renders new template" do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe "GET #index" do
    it "returns http success and renders index template" do
      get :index
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success and renders show template" do
      user = User.create(username: "user", password: "password")
      get :show, params: {id: user.id}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_url(user))
    end
  end

  describe "POST #create" do
    # before :each { u = User.create() }
    context "with valid params" do
      it "creates user and redirects to user show page" do
        post :create, params: {user: {username: "user", password: "password"}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(user_url(User.last))
      end
    end
    
    context "with invalid params" do
      it "flashes errors and renders new template" do
        post :create, params: {user: {username: "user", password: ""}}
        expect(flash[:errors]).to eq(["Password is too short (minimum is 6 characters)"])
        expect(response).to render_template(:new)
      end
    end
    
  end

end
