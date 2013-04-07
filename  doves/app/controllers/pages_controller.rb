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


end
