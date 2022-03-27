@stockPull = IEX::Api::Client.new(
  publishable_token: ENV['iexPublishLive'],
  secret_token: ENV['iexSecretLive'],
  endpoint: 'https://cloud.iexapis.com/v1/'
)

# config.endpoint = 'https://sandbox.iexapis.com/stable'
return @stockPull