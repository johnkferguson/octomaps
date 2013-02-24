#This uses the Github API wrapped in the github_api gem.
#Authentication data has been figured out and is the basic stuff below.
#For more info and documentation, check out:
#http://developer.github.com/v3/
#https://github.com/peter-murach/github

require 'github_api'

github = Github.new do |config|
  config.oauth_token = 'a2ee8af1802be1417e4fcc79595fbcc16f67959c'
  config.ssl         = {:verify => false}
end