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
      var buyCurrency = 'EUR';
      var sellCurrency = 'GBP';
      var fixed_side = 'buy';
      var amount = '40.00';

      await cc.authApi.authenticate(loginId, apiKey);
      var result = await cc.ratesApi.detailed(buyCurrency, sellCurrency, fixed_side, amount);

      expect(result['client_buy_currency'], buyCurrency);
      expect(result['client_sell_currency'], sellCurrency);
      expect(result['fixed_side'], fixed_side);
      expect(result['client_buy_amount'], amount);
    });
  });
}
