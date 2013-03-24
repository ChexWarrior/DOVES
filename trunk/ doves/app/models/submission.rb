class Submission < ActiveRecord::Base

belongs_to :bird
belongs_to :user

def self.subsearch(search)
  search_condition = "%" + search + "%"
  Submission.joins(:bird).where("birds.common_name LIKE ?", search_condition)
 end
end
