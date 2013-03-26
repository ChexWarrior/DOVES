class Multimedium < ActiveRecord::Base
	attr_accessible :submission_id, :type, :time, :image, :size
	belongs_to :submission
	mount_uploader :image, ImageUploader
	
end
