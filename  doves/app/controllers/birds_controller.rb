class BirdsController < ApplicationController

skip_before_filter :verify_authenticity_token, :only => [:sort]

before_filter :ensure_admin, :except => [:index, :show]
  # GET /birds
  # GET /birds.json
  def index
    @birds = Bird.order('birds.position asc').search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @birds }
    end
  end
  
  def reorder
    @birds = Bird.order('birds.position asc')
  end
  
  def sort
	@birds = Bird.all
	@birds.each do |bird|
	bird.position = params['bird'].index(bird.id.to_s) + 1
	bird.save
	end
  end
  
  # GET /birds/1
  # GET /birds/1.json
  def show
    @bird = Bird.find(params[:id])
	@submissions = Submission.scoped_by_bird_id(params[:id]).paginate(:page=> params[:page], :per_page => 10)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bird }
    end
  end

  # GET /birds/new
  # GET /birds/new.json
  def new
    @bird = Bird.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bird }
    end
  end

  # GET /birds/1/edit
  def edit
    @bird = Bird.find(params[:id])
  end

  # POST /birds
  # POST /birds.json
  def create
    @bird = Bird.new(params[:bird])

    respond_to do |format|
      if @bird.save
        format.html { redirect_to @bird, notice: 'Bird was successfully created.' }
        format.json { render json: @bird, status: :created, location: @bird }
      else
        format.html { render action: "new" }
        format.json { render json: @bird.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /birds/1
  # PUT /birds/1.json
  def update
    @bird = Bird.find(params[:id])

    respond_to do |format|
      if @bird.update_attributes(params[:bird])
        format.html { redirect_to @bird, notice: 'Bird was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bird.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /birds/1
  # DELETE /birds/1.json
  def destroy
    @bird = Bird.find(params[:id])
    @bird.destroy

    respond_to do |format|
      format.html { redirect_to birds_url }
      format.json { head :no_content }
    end
  end
  
  # TOGGLE /birds/1
  # TOGGLE /birds/1.json
  def toggle
    @bird = Bird.find(params[:id])
	@bird.toggle
	
    respond_to do |format|
	if @bird.update_attributes(params[:bird])
        format.html { redirect_to birds_url, notice: @bird.common_name + ' was successfully updated.' }
        format.json { head :no_content }
      else
      format.html { redirect_to birds_url, notice: 'Bird update failed.' }
      format.json { head :no_content }
	end
	end
	end
  
end
