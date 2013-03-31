class VotesController < ApplicationController
before_filter :ensure_reviewer_or_admin

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @votes }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/new
  # GET /votes/new.json
  def new
    @vote = Vote.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @vote }
    end
  end

  # GET /votes/1/edit
  def edit
    @vote = Vote.find(params[:id])
  end
  
  # Pending submission controller
  def pending
  # Get user role to determine reviewer and id to determine which results to show.
  @pending = Submission.find(:all, :conditions =>{:status => "pending"})
  @pending.delete_if{|submission| Vote.scoped_by_Submission_id(submission.id).scoped_by_User_id(session[:user].id).scoped_by_round(submission.rounds).exists?}
	# for(int x = 0; x<= id_max; x++)
	# {
	# for(int y = 0; y < 3; x++)
	# {
	# Submission.find(:all, :conditions =>{:status =>"pending", :id => X, :round = Y}) == 
			# Vote.find(:all, :conditions =>{:User_id => session[:user].id}, :Submission_id => X, :rounds => Y) 
	# }
	# }
  @votes = Vote.find(:all, :conditions =>{:User_id => session[:user].id})
	
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(params[:vote])
	@vote.User_id = session[:user].id
    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end
  
  
  def recommend_action

  #find submissions current round
  #find all votes for a submissions current round, count yes and total votes.
  #if vote count < 7 wait for all votes
  #if <4 yes votes dont accept
  #else if 7 yes votes  accept submission any round
  #else if 6 yes votes for round 3 accept
  #else  if 5 or 6 yes votes and round 1 or 2 promote
  #else reject

count = 0 
yes_vote=0
	Votes.find_each(:conditions =>["round = ? AND Submission_id = ?", @submission.rounds, @submission.id]) do |votes|
	  count=count+1   
	  if votes.vote == "Yes"
		 yes_vote=yes_vote + 1
	  end
	end
	if count <7
	   flash[:notice] = "Recommended Action:  Wait for all committee members to finish voting."
	elsif yes_vote == 7
	   flash[:notice] = "Recommended Action:  Accept submission as a verified sighting."
	elsif yes_vote <4
	   flash[:notice] = "Recommended Action: Submission should not be accepted."
	elsif yes_vote == 6 && round ==3
	   flash[:notice] = "Recommended Action:  Accept submission as a verified sighting."
	elsif (yes_vote==5 || yes_vote==6) && (round == 1 || round == 2)
	   flash[:notice] = "Recommended Action: Move submission on to a new round of voting."
	else
	   flash[:notice] = "Recommended Action: Submission should not be accepted."
	end

end


end
