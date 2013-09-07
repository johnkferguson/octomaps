Airbrake.configure do |config|
  config.api_key = '8e3518691dfab432ad11a6a5510a3b7f'
  config.host    = 'fixerr.herokuapp.com'
  config.port    = 80
  config.secure  = config.port == 443
end