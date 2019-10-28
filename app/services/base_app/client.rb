# require 'base_app/client'

module BaseApp
  class Client
    include HTTParty
    include BaseApp::Client::Items

    base_uri 'https://api.thebase.in'
    attr_accessor :client_id, :client_secret, :code, :access_token, :refresh_token, :bearer, :res

    private

    def post_call_api(path, payload = {})
      # TODO: optional setting
      self.class.post(path, { body: payload })
    end

    def get_call_api(path, payload = {})
      # TODO: optional setting
      self.class.get(path, { query: payload })
    end
  end
end
