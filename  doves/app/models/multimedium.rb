class Multimedium < ActiveRecord::Base
	#attr_accessible :submission_id, :image
	belongs_to :submission
	mount_uploader :image, ImageUploader
	
end
