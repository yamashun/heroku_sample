module BaseApiHelper
  def oauth_url
    "https://api.thebase.in/1/oauth/authorize?#{auth_params.to_query}"
  end

  def auth_params
    {
      response_type: 'code',
      client_id: base_client.client_id,
      redirect_uri: Settings.base_auth.redirect_uri,
      scope: 'read_users read_items write_items read_orders write_orders read_savings',
      state: base_client.auth_state,
    }
  end

  def base_client
    @base_client ||= current_user.base_client
  end
end
