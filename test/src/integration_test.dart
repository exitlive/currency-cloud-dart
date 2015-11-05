part of currency_cloud.test;

integration_test() {
  group('integration tests', () {
    CurrencyCloud cc;
    var loginId;
    var apiKey;

    setUp(() {
      loginId = Config.loginId;
      apiKey = Config.apiKey;

      cc = new CurrencyCloud();
    });

    test('authenticate call should set authToken', () async {
      expect(cc.isAuthenticated, false);
      await cc.authApi.authenticate(loginId, apiKey);
      expect(cc.isAuthenticated, true);
    });

    test('ratesApi.detailed() call should return a quote', () async {
      try {
        await cc.authApi.authenticate(loginId, apiKey);
        var result = await cc.ratesApi.detailed(
            'EUR', 'GBP', 'buy', '40.00');
        print(result);
      } on CurrencyCloudException catch(e) {
        print('======= Got Exception ======= ');
        print(e.body);
      }
    });
  });
}
