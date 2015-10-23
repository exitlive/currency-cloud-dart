part of currency_cloud.test;

authenticate_api_test() {
  group('authenticate', () {
    var cc;
    var loginId;
    var apiKey;

    setUp(() {
      loginId = Config.loginId;
      apiKey = Config.apiKey;

      cc = CurrencyCloud.getInstance();
    });

    test('First Test', () async {
      await cc.authenticate(loginId, apiKey);
    });
  });
}
