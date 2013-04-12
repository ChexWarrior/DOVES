require 'will_paginate/array'
class SubmissionsController < ApplicationController

	before_filter :ensure_logged_in, :except => [:show, :index]
	#before_filter :ensure_admin_or_self, :except => [:show, :new, :search, :create]
	before_filter :ensure_user_authorized_to_view, :only => :show
	before_filter :ensure_user_authorized_to_edit, :only => [:edit, :update]
	before_filter :ensure_user_authorized_to_destroy, :only => :destroy
	
  # GET /submissions
  # GET /submissions.json
  def index
    params[:per_page] = 10 if params[:per_page].nil?
	 @submissions = Submission.all if params[:search].nil?
     @submissions = Submission.subsearch(params[:search], params[:field]) if !params[:search].nil?
	 @submissions = @submissions.paginate(:page => params[:page], :per_page => params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @submissions }
    end
  end

	#old vote record
	Record = Struct.new(:voter_name,:vote_time,:comment);

  # GET /submissions/1
  # GET /submissions/1.json
  def show
  
  #if (admin or reviewer) AND (submission is pending and date votable is today or before today)
  # pull in all vote information about this submission and display 
  # if reviewer has voted in this round displayr reviewers vote and all previous round info
  # if reviewer has not voted display option to vote anda ll previous round info
  # vote array (votes)
  # INFO TO DISPLAY: submissions voting date,
  #					 each reviewers vote and comments from previous rounds
  #					 current round
  #					 option to vote if reviewer has not voted yet
    
    @submission = Submission.find(params[:id])
	@vote = Vote.new
	@hasVoted = true
	subStatus = @submission.status
	subId = @submission.id
	if (isadmin? || isreviewer?) && subStatus == "pending"
		#get all votes that have an s_id equal to this submission
		@votes = @submission.votes
		#@comments array will hold all previous comments for display on the screen :M
		@oldRecords = []
		@submission.votes.each{|vote| @oldRecords.push(Record.new(User.find(vote.user_id).first_name,vote.created_at,vote.comments))}
		#don't show any votes or comments for votes made in this round by other reviewers
		@votes.delete_if{|vote| vote.round == @submission.rounds}
		#don't show the editable vote fields if this user has already voted on this submission in this round
		@hasVoted = @submission.votes.scoped_by_user_id(session[:user].id).scoped_by_round(@submission.rounds).exists?
	end


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
	5.times {@submission.multimedia.build}
	
	if @submission.bird_id == 31
		@common_name=@submission.common_name
	else
		@common_name=@submission.bird.common_name
	end
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
	
	@bird = Bird.find_by_common_name(params[:submission][:common_name])
	if @bird.nil? then
		params[:submission][:bird_id]=31  #default to "Other" if we don't find a bird with that name
	else
		params[:submission][:bird_id] = @bird.id
		params[:submission][:common_name]=nil
	end
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


   def ensure_user_authorized_to_view
	@submission = Submission.find(params[:id])
	redirect_to submissions_path, notice: "You are not authorized for that action." and return if !(@submission.user_authorized_to_view?(session[:user]))
  end 
  
   def ensure_user_authorized_to_edit
   	@submission = Submission.find(params[:id])
	redirect_to login_users_path, notice: "You must be logged in to perform that action." and return if !loggedin?
	redirect_to submissions_path, notice: "You are not authorized for that action." and return if !(@submission.user_authorized_to_edit?(session[:user]))
  end 
  
   def ensure_user_authorized_to_destroy
   	@submission = Submission.find(params[:id])
	redirect_to login_users_path, notice: "You must be logged in to perform that action." and return if !loggedin?
	redirect_to submissions_path, notice: "You are not authorized for that action." and return if !(@submission.user_authorized_to_destroy?(session[:user]))
  end 
  
  
  end