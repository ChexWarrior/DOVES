class UsersController < ApplicationController
	
  before_filter :ensure_admin_or_self, :only => [:index, :show, :edit]
  before_filter :ensure_admin, :only => :search
  
  
  # GET /users
  # GET /users.json
  def index
  
  @users = User.search(params[:search], params[:field], params[:levels]).paginate(:page => params[:page], :per_page => params[:per_page])
  flash.now[:notice] = "No Users Found" if @users.length == 0

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def login
	if session[:user]
		flash[:notice] = "Already logged in as #{session[:user].first_name} #{session[:user].last_name} (#{session[:user].email})."
		redirect_to(root_path)

	else
	#Login Form
	end
  end

  def logout
    cookies.delete :user
	session[:user] = nil
	flash[:notice] = "You have been logged out."
	redirect_to(root_path)
  end
  
	def login_attempt
		authorized_user = User.authenticate(params[:email],params[:login_password])
		if authorized_user
			session[:user] = authorized_user
			cookies[:user] = authorized_user
			flash[:notice] = "Successfully logged in as #{authorized_user.first_name} #{authorized_user.last_name} (#{session[:user].email})."
			redirect_to(root_path)
		else
			flash.now[:error] = "Invalid Username or Password"
			render "login"
		end
	end
	
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
	@submissions = Submission.scoped_by_user_id(params[:id]).paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
	@currentlevel = @user.level
  end

  # POST /users
  # POST /users.json
  def create
	params[:user][:level] = 'registered_user' if !isadmin?
    @user = User.new(params[:user])
	#session[:user] = @user if !loggedin?
	
    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
	
	params[:user][:level] = @user.level if !isadmin?

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
	if session[:user].id == params[:id]
		flash.now[:notice] = "You can not delete your own account!" 
	else
		@user = User.find(params[:id])		
		@user.destroy
		respond_to do |format|
		  format.html { redirect_to users_url, notice: "User was deleted.#{session[:user].id} #{params[:id]}" }
		  format.json { head :no_content }
		end
	end

  end
  
end
