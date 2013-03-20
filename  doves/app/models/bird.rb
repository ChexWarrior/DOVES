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
	if self.reviewable.downcase == "yes"
		self.reviewable = "no"
	else 
		self.reviewable = "yes"
	end
end

end
