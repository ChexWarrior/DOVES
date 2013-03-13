class Submission < ActiveRecord::Base

has_one :bird

def created_on
	return "now"
end

end

def self.search(search)
  search_condition = "%" + search + "%"
  find(:all, :conditions => ['title LIKE ? OR description LIKE ?', search_condition, search_condition])
end