class Vote < ActiveRecord::Base

belongs_to :submission
belongs_to :user
	
validates :user_id, :presence => true
validates :submission_id, :presence => true
validates :round, :presence => true
validates_numericality_of :round, :only_integer => true
validates :vote, :presence => true
validate :determine_comment_presence

#based on the VARCOM bylaws
def determine_comment_presence
	if  self.round > 1
		old_vote = Vote.where("round = ?", self.round-1).where("user_id = ?", self.user_id).where("submission_id = ?", self.submission_id).first
		if old_vote.vote != self.vote and self.comments.length == 0
			errors.add(:vote, "You must explain your vote change in the comments field ")
		end
	end
end

end
