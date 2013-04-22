module SubmissionsHelper

def search_params
    [
		['Common Name', 'common_name'],
		['First Name', 'first_name'],
		['Last Name', 'last_name'],
		['Email', 'email']
      
    ]
end

def submission_statuses
    [
      ['Verified', 'verified'],
	  ['Accepted', 'accepted'],
	  ['Pending', 'pending'],
	  ['New', 'new'],
	  ['Incomplete', 'incomplete'],     
      ['Rejected', 'rejected'],
	  ['Not Reviewable', 'not_reviewable']	  
    ]
end
end
