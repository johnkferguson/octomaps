module Octomaps
  class App < Padrino::Application
	register SassInitializer
	use ActiveRecord::ConnectionAdapters::ConnectionManagement
	register Padrino::Rendering
	register Padrino::Mailer
	register Padrino::Helpers
	register Padrino::Sprockets
  sprockets :minify => (Padrino.env == :production)

	enable :sessions

	get :index do
	  render 'public/home'
	end

	get :notfound do
	  render 'public/notfound'
	end

	post :index do

	end

	get :map do
		owner = params[:owner].strip.downcase
		repo = params[:repo].strip.downcase
		full_repo_name = "#{owner}/#{repo}"
		if GithubRepositoryService.new(full_repo_name).update_database_based_upon_github
			@repo = Repository.find_by_full_name(full_repo_name)
			render 'public/map'
		else 
			redirect_to :notfound
		end
		
	end


# Original map route from old Sinatra app
#
# get '/map' do
#   @repo = Repo.new(params[:owner], params[:repo])
#   begin
#     if params[:submit1]
#       @repo.locations
#     elsif params[:submit2]
#       @repo.country_locations
#     end
#   rescue
#     redirect '/notfound'
#   end
#   data_table_markers = GoogleVisualr::DataTable.new
#   data_table_markers.new_column('string' , 'Location' )
#   data_table_markers.new_column('number' , 'Contributions')
#   data_table_markers.add_rows(@repo.location_count.size)
#   i = 0
#   @repo.location_count.each do |location, count|
#     unless location == "Location Unknown"
#       data_table_markers.set_cell(i,0,location)
#       data_table_markers.set_cell(i,1, count)
#       i += 1
#     end
#   end
#   if params[:submit1]
#     opts = { :displayMode => 'markers', :region => 'world', :legend => 'none',
#              :colors => ['FF8F86', 'C43512']}
#   elsif params[:submit2]
#     opts = { :displayMode => 'region', :region => 'world', :legend => 'none',
#              :colors => ['FF8F86', 'C43512']}
#   end
#   @chart_markers = GoogleVisualr::Interactive::GeoChart.new(data_table_markers, opts)

#   erb :map

# end


	# map show controller
	# take the params
	# @repo = Repository.find_by_full_name(params[:name])
	# data_table_markers = GoogleVisualr::DataTable.new
	# data_table_markers.new_column('string' , 'Location' )
	# data_table_markers.new_column('number' , 'Contributions')
	# data_table_markers.add_rows(@repo.location_count.size)



	##
	# Caching support
	#
	# register Padrino::Cache
	# enable :caching
	#
	# You can customize caching store engines:
	#
	# set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
	# set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
	# set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
	# set :cache, Padrino::Cache::Store::Memory.new(50)
	# set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
	#

	##
	# Application configuration options
	#
	# set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
	# set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
	# set :show_exceptions, true    # Shows a stack trace in browser (default for development)
	# set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
	# set :public_folder, 'foo/bar' # Location for static assets (default root/public)
	# set :reload, false            # Reload application files (default in development)
	# set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
	# set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
	# disable :sessions             # Disabled sessions by default (enable if needed)
	# disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
	# layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
	#

	##
	# You can configure for a specified environment like:
	#
	#   configure :development do
	#     set :foo, :bar
	#     disable :asset_stamp # no asset timestamping for dev
	#   end
	#

	##
	# You can manage errors like:
	#
	#   error 404 do
	#     render 'errors/404'
	#   end
	#
	#   error 505 do
	#     render 'errors/505'
	#   end
	#
  end
end
