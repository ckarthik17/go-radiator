require "rubygems"
require "bundler/setup"

require 'httpclient'

class Retriever

  def get_cctray_response url, domain, user, password
    http_client = HTTPClient.new
    http_client.set_auth(domain, user, password)

    http_client.get(url)
  end

end