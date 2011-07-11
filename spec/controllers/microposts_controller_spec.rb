require 'spec_helper'

describe MicropostsController do

render_views

  describe "Access control" do
    
    it "should deny aces to create" do
      post :create
      response.should redirect_to(signin_path)
    end
    
    it "should deny acess to destroy" do
      delete :create, :id => 1
      response.should redirect_to(signin_path)
    end
    
  end
  
  describe "POST create" do
    
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end
    
    describe "failure" do
    
      before(:each) do
        @attr = {:content  => ""}
      end
      
    it "should not create a micropost" do
      lambda do
        post :create, :micropost => @attr
      end.should_not change(Micropost, :count)
    end
    
    it "should re-render the home page" do
      
      post :create, :micropost => @attr
      response.should render_template('pages/home')
      
    end
      
    end
    
    describe "success" do
      
      before(:each) do
        @attr = {:content => "foo bar"}
      end
      
      it "should create a micropost" do
        lambda do
          post :create, :micropost => @attr
        end.should change(Micropost, :count).by(1)
      end
      
      it "shoudl redirect to root path" do
        post :create, :micropost  => @attr
        response.should redirect_to(root_path)
      end
      
      it "should have a flash success message" do
        post :create, :micropost  => @attr
        flash[:success].should =~ /micropost created/i
      end
      
    end
    
    
  end

end