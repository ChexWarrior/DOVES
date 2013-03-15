class Multimedium < ActiveRecord::Base
	def self.save(upload)
		name =  upload['multimedia'].original_filename
		directory = "public/media"
		# create the file path
		path = File.join(directory, name)
		# write the file
		File.open(path, "wb") { |f| f.write(upload['multimedia'].read) }
	end
end
