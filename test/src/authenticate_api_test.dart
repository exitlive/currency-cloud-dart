part of currency_cloud.test;

authenticate_api_test() {
  group('unit tests', () {
    group('authenticate', () {
      var currencyCloudMock;

      setUp(() {

      });
    });
  });

  group('integration tests', () {
    group('authenticate', () {
      var cc;
      var loginId;
      var apiKey;

      setUp(() {
        loginId = Config.loginId;
        apiKey = Config.apiKey;

        cc = new CurrencyCloud();
      });

      test('authenticate.api integration test, should set authToken', () async {
        expect(cc.isAuthenticated, false);
        await cc.authApi.authenticate(loginId, apiKey);
        expect(cc.isAuthenticated, true);
      });
    });
  });
}
