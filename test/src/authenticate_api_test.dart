part of currency_cloud.test;

authenticate_api_test() {
  group('unit tests', () {
    group('authenticate', () {
      var mockClient;
      var authToken;
      AuthenticateApi authenticateApi;

      setUp(() {
        mockClient = new MockClient();
        authToken = new AuthToken();
        authenticateApi = new AuthenticateApi(authToken);
        authenticateApi.client = mockClient;
      });

      test('call to authenticate should do post call with correct body', () async {
        var authTokenString = 'funnyAuthTokenString';
        var loginId = 'someLoginId';
        var apiKey = 'someApiKey';
        var url = '/authenticate/api';
        authToken.reset();

        var body = {};
        body['login_id'] = loginId;
        body['api_key'] = apiKey;

        when(mockClient.post(url, body: body)).thenReturn(new Future.value({'auth_token': authTokenString}));
        await authenticateApi.authenticate(loginId, apiKey);
        verify(mockClient.post(url, body: body)).called(1);
        expect(authToken.value, authTokenString);
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
