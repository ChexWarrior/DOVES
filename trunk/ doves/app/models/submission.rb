class Submission < ActiveRecord::Base

has_one :bird

def created_on
	return "now"
end

end
