RSpec.configure do |config|
  config.around(:each, :vcr) do |spec|
    paths_and_filename = paths_and_filename(spec.metadata[:full_description])
    VCR.use_cassette(paths_and_filename) { spec.call }
  end
end

VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.default_cassette_options = { record: :new_episodes }
end

def paths_and_filename(description)
  description.split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
end
