class Submission < ActiveRecord::Base

has_many :multimedia, :dependent => :destroy
has_many :votes
accepts_nested_attributes_for :multimedia, :allow_destroy => true
attr_accessor :force_submit
belongs_to :bird
belongs_to :user

 

 validates :age, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :sex, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :plumage, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :location, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :sight_date_time, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :habitat, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :gps, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :coobservers, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :length_of_obs, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :distance_from, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :detailed_description, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :detailed_behavior, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :distinguished_char, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :prev_bird_exp, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :optical_equipment, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :references, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :sub_recall, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :guide_use, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}
 validates :unusual, :presence => true, :unless => Proc.new { |ex| ex.status == "incomplete"}




def self.subsearch(search, option, status)
  search_condition = "%" + search + "%"
  #fix for sql injection!
  case option 
	when "common_name" 
		Submission.joins(:bird).where("(birds.common_name LIKE ? OR submissions.common_name LIKE ?) AND status in (?)", search_condition, search_condition, status)
	when "first_name"
		Submission.joins(:user).where("users.first_name LIKE ? AND status in (?)", search_condition, status)
	when "last_name"
		Submission.joins(:user).where("users.last_name LIKE ? AND status in (?)", search_condition, status)
	when "email"
		Submission.joins(:user).where("users.email LIKE ? AND status in (?)", search_condition, status)
	else Submission.find(:all)
  end


 end
 
 def user_authorized_to_view?(user)
	if !user.nil? then
	case status
		when "incomplete"
			if (user.level == "admin") or (user.id == user_id)
				true
			else
				false
			end
		when "new"
			if (user.level == "admin") or (user.id == user_id)
				true
			else
				false
			end
		when "pending"
			if (user.level == "admin") or (user.level == "reviewer") or (user.id == user_id)
				true
			else
				false
			end
		when "accepted"
			true
		when "verified"
			true
		when "rejected"
			if (user.level == "admin") or (user.level ==  "reviewer") or (user.id == user_id)
				true
			else
				false
			end
		else
			if (user.level == "admin") or (user.id == user_id)
				true
			else
				false
			end
		end
	else
		true if status == 'verified'
	end
 end
 
  def user_authorized_to_edit?(user)
	if user then
	case status
		when "incomplete"
			if (user.id == user_id) or (user.level == "admin")
				true
			else
				false
			end
		when "new"
			if (user.level == "admin")
				true
			else
				false
			end
		else
			if (user.level == "admin")
				true
			else
				false
			end
	end
	
	end
 end
 
 def user_authorized_to_destroy?(user)
	if user then
	case status
		when "incomplete"
			if (user.id == user_id) or (user.level == "admin")
				true
			else
				false
			end
		when "new"
			if (user.id == user_id)
				true
			else
				false
			end
		else
			if (user.level == "admin")
				true
			else
				false
			end
	end
	end
 end
 
 
 
end