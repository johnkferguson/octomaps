require 'rubygems'
require 'octokit'
require 'pp'
require 'json'

#returns an array of all usernames from a repo
def repo_contrib_locs(user_repo)
  repo_contribs = Octokit.contribs(user_repo)
  contrib_locs = repo_contribs.collect { |user| user.fetch("login") }
  contrib_locs
end