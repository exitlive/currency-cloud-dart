library currency_cloud.authenticate_api_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:currency_cloud/currency_cloud.dart';
import 'mock_client.dart';

main() {
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
