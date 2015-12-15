part of currency_cloud;

class AuthenticateApi extends CurrencyCloudApi {
  String loginId, apiKey;

  AuthenticateApi(this.loginId, this.apiKey, authToken) : super(authToken);

  /// Authenticates this [CurrencyCloud] using given [loginId] and [apiKey]. This [CurrencyCloud] instance can
  /// only be used after authentication.
  authenticate() async {
    // Save credentials for relogin in case our [AuthToken] expires
    this.loginId = loginId;
    this.apiKey = apiKey;

    // Make sure we are in unauthenticated state
    _authToken.reset;

    var url = '/authenticate/api';
    var body = {'login_id': loginId, 'api_key': apiKey,};

    var response = await client.post(url, body: body);

    _authToken.value = response['auth_token'];
  }

  /// Closes authenticated Session
  closeSession() async {
    var url = '/authenticate/close_session';

    await client.post(url);
    _authToken.reset;
  }
}
