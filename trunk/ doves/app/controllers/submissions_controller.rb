class SubmissionsController < ApplicationController

	before_filter :ensure_logged_in, :except => [:show, :search]
	before_filter :ensure_admin_or_self, :except => [:show, :new, :search, :create]
	
  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @submission }
    end
  end

  # GET /submissions/new
  # GET /submissions/new.json
  def new
  
    @submission = Submission.new
	5.times {@submission.multimedia.build}
	
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @submission }
    end
  end

  # GET /submissions/1/edit
  def edit
    @submission = Submission.find(params[:id])
	@common_name=@submission.bird.common_name
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(params[:submission])
	
	@submission.user_id = session[:user].id
	@bird = Bird.find_by_common_name(@submission.common_name)
	if @bird.nil? then
		@submission.bird_id=31  #default to "Other" if we don't find a bird with that name
	else
		@submission.bird_id = @bird.id
		@submission.common_name=nil
	end
	5.times {@submission.multimedia.build}
	

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render json: @submission, status: :created, location: @submission }
      else
        format.html { render action: "new" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /submissions/1
  # PUT /submissions/1.json
  def update
    @submission = Submission.find(params[:id])

    respond_to do |format|
      if @submission.update_attributes(params[:submission])
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy

    respond_to do |format|
      format.html { redirect_to submissions_url }
      format.json { head :no_content }
    end
  end


  def search
	 @submissions = []
     @submissions = Submission.subsearch(params[:search], params[:field]) if !params[:search].nil?
	 @selected = params[:field]
	 
	 respond_to do |format|
      format.html # search.html.erb
      format.json { render json: @submissions }
    end
  end
end