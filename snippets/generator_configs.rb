environment <<-APP_GENERATORS
  config.generators do |g|
    g.orm :active_record
    g.test_framework :rspec, 
      :fixtures => true, 
      :view_specs => false, 
      :helper_specs => false, 
      :routing_specs => false, 
      :controller_specs => false, 
      :request_specs => false
    g.fixture_replacement :factory_bot, :dir => "spec/factories"
  end
  config.time_zone = 'Eastern Time (US & Canada)'
APP_GENERATORS