library currency_cloud.payments_api_test;

import 'package:test/test.dart';

import 'package:currency_cloud/currency_cloud.dart';
import 'mock_client.dart';

main() {
  group('PaymentsApi', () {
    PaymentsApi paymentsApi;
    MockClient mockClient;
    AuthToken authToken;

    setUp(() {
      mockClient = new MockClient();
      authToken = new AuthToken();
      paymentsApi = new PaymentsApi(authToken);
      paymentsApi.client = mockClient;
    });

    test('create() should call client.post() with correct body and return result', () {
    });
  });
}