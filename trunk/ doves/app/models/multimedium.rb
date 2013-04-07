class Multimedium < ActiveRecord::Base
	#attr_accessible :submission_id, :image
	belongs_to :submission, :counter_cache => :media
	mount_uploader :image, ImageUploader
	
	after_save { |multimedium| multimedium.destroy if multimedium.image.blank? }
end
