part of currency_cloud;

class AuthenticateApi extends CurrencyCloudApi {
  AuthenticateApi(authToken) : super(authToken);

  /// Authenticates this [CurrencyCloud] using given [loginId] and [apiKey]. This [CurrencyCloud] instance can
  /// only be used after authentication.
  authenticate(String loginId, String apiKey) async {
    // Make sure we are in unauthenticated state
    _authToken = null;

    var url = '/authenticate/api';
    var body = {};
    body['login_id'] = loginId;
    body['api_key'] = apiKey;

    await _post(url, body: body);

    _authToken = body['auth_token'];
  }
}
