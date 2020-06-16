Airbrake.configure do |config|
  config.host = 'https://errbit.brandnewops.com'
  config.project_id = 1 # required, but any positive integer works
  config.project_key = '<project-key-from-errbit>'

  config.environment = Rails.env
  config.ignore_environments = %w(development test)
  
  # A list of parameters that should be filtered out of what is sent to Airbrake
  # https://github.com/airbrake/airbrake#integration-with-filter_parameters
  # https://github.com/airbrake/airbrake-ruby#blacklist_keys
  config.blacklist_keys = Rails.application.config.filter_parameters
end

# Rancher sends a SIGTERM signal to kill containers and we're fine with that so we can have Airbrake ignore that
Airbrake.add_filter do |notice|
  if notice[:errors].any? { |error| error[:type] == "SignalException" && error[:message] == "SIGTERM" }
    notice.ignore!
  end
end
