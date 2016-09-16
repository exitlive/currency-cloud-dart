@Skip('Authentication is now handled by CurrencyCloudClient')
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
    var loginId;
    var apiKey;

    setUp(() {
      mockClient = new MockClient();
      authToken = new AuthToken();
      loginId = 'someLoginId';
      apiKey = 'someApiKey';
      authenticateApi = new AuthenticateApi(mockClient);
      authenticateApi.client = mockClient;
    });

    test('call to authenticate should do post call with correct body', () async {
      var authTokenString = 'funnyAuthTokenString';
      var url = '/authenticate/api';
      authToken.reset();

      var body = {'login_id': loginId, 'api_key': apiKey};

      when(mockClient.post(url, body: body)).thenReturn(new Future.value({'auth_token': authTokenString}));
      await authenticateApi.authenticate();
      verify(mockClient.post(url, body: body)).called(1);
      expect(authToken.value, authTokenString);
    });
  });
}
