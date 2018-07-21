require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr'
  config.hook_into :webmock
  config.allow_http_connections_when_no_cassette = true
  config.configure_rspec_metadata!
  config.debug_logger = File.open('log/vcr.log', 'w')
  config.before_record do |interaction|
    if %w(Fc-Access-Key Fc-Access-Signature).in? interaction.request.headers.keys
      interaction.request.headers['Fc-Access-Key'][0].sub!(/.*+/, '<Fc-Access-Key>')
      interaction.request.headers['Fc-Access-Signature'][0].sub!(/.*+/, '<Fc-Access-Signature>')
    end
  end
end
