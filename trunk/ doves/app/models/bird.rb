class Bird < ActiveRecord::Base

validates :common_name, :presence => true, :uniqueness => true
validates :reviewable, :presence => true
validate :yesorno

#Right now we have a text box for the reviewable field
#where the admin would either put "yes" or "no" - the 
#function below checks for that. But later, I want to 
#just make it a check box instead. - Erek

def yesorno
	if reviewable.downcase != "yes" && reviewable.downcase != "no"
		errors.add(:reviewable, "must be either \"yes\" or \"no\"")
	end
end

end
