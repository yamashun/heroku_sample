class BaseClientService
  include HTTParty
  base_uri 'https://api.thebase.in'

  attr_accessor :client_id, :client_secret, :code, :access_token, :refresh_token, :bearer

  def initialize(client)
    @client = client
    @client_id = client.client_id
    @client_secret = client.client_secret
    @code = client.code
    @bearer = client.access_token
  end

  def login
    payload = {
      grant_type: 'authorization_code',
      client_id: client_id,
      client_secret: client_secret,
      code: code,
      redirect_uri: Settings.base_auth.redirect_uri
    }
    res = post_call_api('/1/oauth/token', payload)
    if res['access_token'].present?
      @client.update!(access_token: res['access_token'])
      @bearer = res['access_token']
    else
      # TODO: error handling
      raise StandardError
    end
  end

  def users
    res = get_call_api('/1/users/me', {})
  end

  def items
    res = get_call_api('/1/items', {})
  end

  def orders
    res = get_call_api('/1/orders', {})
  end

  def order_detail(unique_key)
    res = get_call_api("/1/orders/detail/#{unique_key}", {})
  end

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
