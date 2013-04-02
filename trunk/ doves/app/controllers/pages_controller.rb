class PagesController < ApplicationController
before_filter :ensure_admin, :except => [:about, :home, :sitemap]
  respond_to :html, :js

require 'will_paginate/array'

def admin
	@votes = Vote.all
end

def home
	@multimedia_all = Multimedium.where("multimedia.image IS NOT NULL")
	@multimedia = @multimedia_all.sample(5)
end

def user_search
	@users = User.all
     #@users = User.search(params[:search], params[:field]) if !params[:search].nil?
	 #@user_field_selected = params[:field]	 
	 #render :layout =>false
    respond_to do |format|
        format.js { render :layout=>false }
    end
  end

end
