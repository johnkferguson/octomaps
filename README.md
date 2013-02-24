GithubMaps
==========

**Basic Project Description:** Displays all contributors to an open-source project on a map based upon the contributor's location.	
	
##Main Components

GithubMaps use the following main components:

####[Github API](http://developer.github.com/)
The Github API allows for getting all sorts of information from Github. The two relevant pieces of data for this project are:

1. [A list of contributors to a project.](http://developer.github.com/v3/repos/#list-contributors)
2. [A user's location](http://developer.github.com/v3/users/)

####[Octokit](https://github.com/pengwynn/octokit)
Octokit is a ruby gem that acts as a wrapper to the github api. Once again, the relevant data are project contributors and contributor's location. The appropriate methods for dealing with this data are [here](https://github.com/pengwynn/octokit/blob/master/lib/octokit/client/repositories.rb) and [here](https://github.com/pengwynn/octokit/blob/master/lib/octokit/client/users.rb). 

####[JSON](https://github.com/flori/json)
All github api output is in json. 

####Maps API
A maps api will display contributor's locations.

####[Sinatra](http://www.sinatrarb.com/)
Sinatra pulls everything all together.

##Planned features
* Obtain user ids of contributors to a project
* Determine contributor's location
* Validate and clean location data (ie handle users who don't have locations or who have vague locations (ie "USA"))
* Make any valid locations intelligible to the Maps API protocol
* Allow users to input and submit name of GitHub project via webform
* Users should receive project contributor's locations plotted on a map
* Map should only show relevant area (if all contribs are in USA, should not show entire world)

