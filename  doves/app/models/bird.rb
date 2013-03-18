class Bird < ActiveRecord::Base

validates :common_name, :presence => true, :uniqueness => true
validates :reviewable, :presence => true
validate :yesorno


def yesorno
	if reviewable == nil
		errors.add(:reviewable, "must be either \"yes\" or \"no\"")
	end
end

def toggle
	if reviewable.downcase == "yes"
		reviewable = "no"
	else 
		reviewable = "yes"
	end
end

end
