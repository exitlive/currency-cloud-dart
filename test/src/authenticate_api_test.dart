part of currency_cloud.test;

authenticate_api_test() {
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
}
