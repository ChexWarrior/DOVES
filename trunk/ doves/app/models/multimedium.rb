class Multimedium < ActiveRecord::Base
	#attr_accessible :submission_id, :image
	belongs_to :submission, :counter_cache => :media
	mount_uploader :image, ImageUploader
	mount_uploader :video, VideoUploader
	mount_uploader :audio, AudioUploader
		
	after_save { |multimedium| multimedium.destroy if multimedium.image.blank? and multimedium.video.blank? and multimedium.audio.blank? }
end
