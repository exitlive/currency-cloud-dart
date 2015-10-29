part of currency_cloud;

class AuthenticateApi extends CurrencyCloudApi {
  AuthenticateApi(authToken) : super(authToken);

  /// Authenticates this [CurrencyCloud] using given [loginId] and [apiKey]. This [CurrencyCloud] instance can
  /// only be used after authentication.
  authenticate(String loginId, String apiKey) async {
    // Make sure we are in unauthenticated state
    _authToken.reset;

    var url = '/authenticate/api';
    var body = {};
    body['login_id'] = loginId;
    body['api_key'] = apiKey;

    var response = await client.post(url, body: body);

    _authToken.value = response['auth_token'];
  }
}
