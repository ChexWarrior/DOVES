class PagesController < ApplicationController
before_filter :ensure_admin, :except => [:about, :home, :sitemap]
  respond_to :html, :js

require 'will_paginate/array'

def admin
	@votes = Vote.all
    @posts = Post.order("created_on DESC").paginate(:page => params[:page], :per_page => 25)
	@birds = Bird.all
	@numnew = Submission.scoped_by_status('new').count
	@numpending = Submission.scoped_by_status('pending').count
end

def home
	@multimedia_all = Multimedium.joins(:submission).where("multimedia.image IS NOT NULL AND submissions.status ='verified'")
	@multimedia = @multimedia_all.sample(5)
	@post = Post.order("created_on DESC").first
end


end
