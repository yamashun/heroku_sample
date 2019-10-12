class BaseClientService
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
      puts res
      # TODO: error handling
      # {"error"=>"invalid_request", "error_description"=>"認可コードの有効期限が切れています。"}
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

  BASE_API_END_POINT = 'https://api.thebase.in'.freeze

  def post_call_api(path, payload)
    login if @beare.blank?

    conn = Faraday.new(:url => BASE_API_END_POINT) do |builder|
      builder.request  :url_encoded
      builder.response :logger
      builder.adapter  :net_http
    end
    response = conn.post do |req|
      req.url path, payload
    end
    JSON.parse(response.body)
  end

  def get_call_api(path, payload = {})
    login if @beare.blank?

    conn = Faraday.new(:url => BASE_API_END_POINT) do |builder|
      builder.request  :url_encoded
      builder.response :logger
      builder.adapter  :net_http
      builder.headers['Authorization'] = "Bearer #{bearer}"
    end
    response = conn.get do |req|
      req.url path, payload
    end
    JSON.parse(response.body)
  end
end
