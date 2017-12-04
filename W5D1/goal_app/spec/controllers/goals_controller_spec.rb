require 'rails_helper'

RSpec.describe GoalsController, type: :controller do

  describe "GET #new" do
    it "renders new template and succeeds" do
      get :new
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    before(:each) do
      u = User.create(username: "username", password: "password")
      allow(subject).to receive(:current_user).and_return(u)
    end 
    
    context "with valid params" do
      it "creates goal and redirects to goal show" do
        post :create, params: {goal: {title: "goaltitle", details: "goaldeets", private: false, completed: false}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(goal_url(Goal.last))
      end
    end
    
    context "with invalid params" do
      it "flashes errors and renders new" do
        post :create, params: {goal: {title: "", details: "goaldeets", private: false, completed: false}}
        expect(flash[:errors]).to eq(["Title can't be blank"])
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "renders edit template" do
      generate_user_and_goal
      get :edit, params: {id: Goal.last.id}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    
    before(:each) do
      generate_user_and_goal
      allow(subject).to receive(:current_user).and_return(User.last)
    end
    
    context "with valid params" do
      it "updates the goal in db and redirects to goal show page" do
        
        patch :update, params: {id: Goal.last.id, goal: {title: "newgoaltitle", details: "goaldeets", private: false, completed: false}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(goal_url(Goal.last))
      end
    end
    context "with invalid params" do
      it "flashes errors and renders edit page" do
        patch :update, params: {id: Goal.last.id, goal: {title: "", details: "goaldeets", private: false, completed: false}}
        expect(flash[:errors]).to eq(["Title can't be blank"])
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE #destroy" do
    before(:each) do
      generate_user_and_goal
      allow(subject).to receive(:current_user).and_return(User.last)
    end
    
    it 'removes goal from database and redirects to user show page' do
      delete :destroy, params: { id: Goal.last.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(user_url(User.last))
    end
  end

end
