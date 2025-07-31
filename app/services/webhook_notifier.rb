require 'net/http'
require 'uri'

class WebhookNotifier
  WEBHOOK_URL = 'https://webhook.site/f0d63823-1d51-42a0-91ca-41973c22af2f' # Replace with actual

    def self.call(tag)
        uri = URI(WEBHOOK_URL)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Post.new(uri.path, { 'Content-Type': 'application/json' })
        request.body = { tag: tag }.to_json
        http.request(request)
    end
end