Octomaps
==========

Octomaps plots the locations of contributors to any open-source project on a map. 

Check out Octomaps in action here: [http://www.octomaps.com](http://www.octomaps.com)

	
##Octomaps' Key Components
Octomaps is built with [Ruby](http://www.ruby-lang.org/en/) and uses the [Sinatra](http://www.sinatrarb.com/) web framework.

All information regarding contributors to a Github repository and those contributors' locations are retrieved using the [Github API](http://developer.github.com/). Github's API is very robust and its documentation is quite thorough. The relevant parts that Octomaps utilizes are: (1) [retrieving a list of contributors to a project](http://developer.github.com/v3/repos/#list-contributors) & (2) [getting a user's location](http://developer.github.com/v3/users/).

Octomaps uses [Octokit](https://github.com/pengwynn/octokit), a GitHub API wrapper, to ineract with the Github API. All data retrieved through the API is returned in [JSON](https://github.com/flori/json).

[Datamapper](http://datamapper.org/) is used to interact with the data that is stored in a Postgres database.

Locations are plotted using the [Google Visualization API](https://developers.google.com/chart/interactive/docs/reference) and its corresponding Ruby wrapper, [Google Visualr](https://github.com/winston/google_visualr).

For a much more granular perspective on how Octomaps' code works, check out [A Step by Step Overview of How Octomaps Works](https://github.com/JohnKellyFerguson/octomaps/wiki/A-Step-by-Step-Overview-of-How-Octomaps-Works)


##Running Octomaps on Your Local Machine
1. [Fork the repository.](https://github.com/JohnKellyFerguson/octomaps/fork_select)
2. Bundle to make sure you have all the necessary gems.
3. Set up a database to be used with Octomaps. Postgres is preferred.
4. Create a database.rb file in your Octomaps home directory. Within the file you want to provide your datebase location. The syntax is as follows:
`
ENV['DATABASE_URL'] ||= 'postgres://your_host_name_here@localhost/name_of_your_db_here'
`
5. Within the repoclass.rb file, adjust the login and password for Octokit to reflect your information.
6. Start playing with Octomaps!

##Contributing to Octomaps
If you'd like to contribute to octomaps, fork our repository and submit a pull request. Also, be sure to check out [our issues page](https://github.com/JohnKellyFerguson/octomaps/issues?state=open) for a list of things we are working on.

##About Us
Octomaps was built by [John Kelly Ferguson](https://github.com/JohnKellyFerguson), [Justin Kestler](https://github.com/meowist), [Masha Rikhter](https://github.com/mrikhter) while attending the [Flatiron School](http://flatironschool.com/).
