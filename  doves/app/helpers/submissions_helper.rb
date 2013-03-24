module SubmissionsHelper

def search_params
    [
      ['First Name', 'first_name'],
      ['Last Name', 'last_name'],
      ['Email', 'email'],
      ['Common Name', 'common_name']
    ]
end
end
