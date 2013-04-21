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
      ['Incomplete', 'incomplete'],
      ['New', 'new'],
      ['Pending', 'pending'],
	  ['Accepted', 'accepted'],
      ['Verified', 'verified'],
      ['Rejected', 'rejected'],
	  ['Not Reviewable', 'not_reviewable']
	  
    ]
end
end
