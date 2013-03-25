class Submission < ActiveRecord::Base

has_many :multimedia
has_many :votes

belongs_to :bird
belongs_to :user

validates :common_name, :presence => true
validates :s_degree, :presence => true
validates :age, :presence => true
validates :sex, :presence => true
validates :plumage, :presence => true
validates :location, :presence => true
validates :region, :presence => true
validates :sight_date_time, :presence => true
validates :habitat, :presence => true
validates :gps, :presence => true
validates :coobservers, :presence => true
validates :length_of_obs, :presence => true
validates :distance_from, :presence => true
validates :detailed_description, :presence => true
validates :detailed_behavior, :presence => true
validates :distinguished_char, :presence => true
validates :prev_bird_exp, :presence => true
validates :optical_equipment, :presence => true
validates :references, :presence => true
validates :sub_recall, :presence => true
validates :guide_use, :presence => true
validates :unusual, :presence => true

def self.subsearch(search, option)
  search_condition = "%" + search + "%"
  #fix for sql injection!
  case option 
	when "common_name" 
		Submission.joins(:bird).where("birds.common_name LIKE ?", search_condition)
	when "first_name"
		Submission.joins(:user).where("users.first_name LIKE ?", search_condition)
	when "last_name"
		Submission.joins(:user).where("users.last_name LIKE ?", search_condition)
	when "email"
		Submission.joins(:user).where("users.email LIKE ?", search_condition)
	else Submission.find(:all)
  end
  

 end
end