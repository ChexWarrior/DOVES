class PagesController < ApplicationController
before_filter :ensure_admin, :except => [:about, :home, :sitemap]
  respond_to :html, :js

require 'will_paginate/array'

def admin
	@votes = Vote.all
    @posts = Post.order("created_on DESC").paginate(:page => params[:page], :per_page => 25)
end

def home
	@multimedia_all = Multimedium.where("multimedia.image IS NOT NULL")
	@multimedia = @multimedia_all.sample(5)
	@posts = Post.order("created_on DESC").limit(1)
end


end
