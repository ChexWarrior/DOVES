module SubmissionsHelper

def search_params
    [
      ['First Name', 'first_name'],
      ['Last Name', 'last_name'],
      ['Email', 'email'],
      ['Common Name', 'common_name']
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
