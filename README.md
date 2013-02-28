Octomaps
==========

Octomaps plots the locations of contributors to any open-source project on a map. 

Check out Octomaps in action here: [http://www.octomaps.com](http://www.octomaps.com)

	
##Octomaps' Key Components
Octomaps is built with [Ruby](http://www.ruby-lang.org/en/) and uses the [Sinatra](http://www.sinatrarb.com/) web framework.

All information regarding contributors to a Github repository and those contributors' locations are retrieved using the [Github API](http://developer.github.com/). Github's API is very robust and its documentation is quite thorough. The relevant parts that Octomaps utilizes are: (1) [retrieving a list of contributors to a project](http://developer.github.com/v3/repos/#list-contributors) & (2) [getting a user's location](http://developer.github.com/v3/users/).

Octomaps uses [Octokit](https://github.com/pengwynn/octokit), a GitHub API wrappter, to ineract with the Github API. All data retrieved through the API is returned in [JSON](https://github.com/flori/json).

[Datamapper](http://datamapper.org/) is used to interact with the data that is stored in a Postgres database.

Locations are plotted using the [Google Visualization API](https://developers.google.com/chart/interactive/docs/reference) and its corresponding Ruby wrapper, [Google Visualr](https://github.com/winston/google_visualr).

For a much more granular perspective on how Octomaps' code works, check out [A Step by Step Overview of How Octomaps Works](https://github.com/JohnKellyFerguson/octomaps/wiki/A-Step-by-Step-Overview-of-How-Octomaps-Works)


##Getting Started
1. Clone or fork the repository
2. Bundle
3. Install postgres if you don't already have it
3. Create a postgres database
4. Create a database.rb file that links to Syntax is as follows:
```ruby
ENV['DATABASE_URL'] ||= 'postgres://your_host_name_here@localhost/'
```
5. Set up an authentication.rb file

##About Us
Octomaps was built by [John Kelly Ferguson](https://github.com/JohnKellyFerguson), [Justin Kestler](https://github.com/meowist), [Masha Rikhter](https://github.com/mrikhter) while attending the [Flatiron School](http://flatironschool.com/).
