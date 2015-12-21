part of currency_cloud;

class AuthenticateApi extends CurrencyCloudApi {
  AuthenticateApi(client) : super(client);

  /// Authenticates this [CurrencyCloud] using given [loginId] and [apiKey]. This [CurrencyCloud] instance can
  /// only be used after authentication.
  authenticate() => client.authenticate();

  /// Closes authenticated Session
  closeSession() => client.closeSession();
}
