class Multimedium < ActiveRecord::Base

	belongs_to :submission, :counter_cache => :media
	mount_uploader :image, ImageUploader
	mount_uploader :video, VideoUploader
	mount_uploader :audio, AudioUploader
	
	validate :image_size_validation
	validate :video_size_validation
	validate :audio_size_validation
		
	after_save { |multimedium| multimedium.destroy if multimedium.image.blank? and multimedium.video.blank? and multimedium.audio.blank? }

	
	def image_size_validation
		errors[:image] << "should be less than 5MB" if image.size > 5.megabytes
	end
	def video_size_validation
		errors[:video] << "should be less than 15MB" if video.size > 15.megabytes
	end
	def audio_size_validation
		errors[:audio] << "should be less than 5MB" if audio.size > 5.megabytes
	end
end
