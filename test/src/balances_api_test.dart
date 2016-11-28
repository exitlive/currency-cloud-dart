library currency_cloud.rates_api_test;

import 'dart:async';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:currency_cloud/currency_cloud.dart';

import 'mock_client.dart';

main() {
  group('balances', () {
    BalancesApi balancesApi;
    MockClient mockClient;

    setUp(() {
      mockClient = new MockClient();
      balancesApi = new BalancesApi(mockClient);
      balancesApi.client = mockClient;
    });

    test('getting the balance should return the correct response', () async {
      var currency = new Currency('USD');

      var expectedResponse = {
        "id": "18230F1D-648A-406A-AD1F-A09CBC02E9E9",
        "account_id": "TcC",
        "currency": "USD",
        "amount": "1000.00",
        "created_at": "2014-01-12T12:24:19+00:00",
        "updated_at": "2014-01-12T12:24:19+00:00"
      };

      var uri = '/balances/USD';

      when(mockClient.get(any, body: any)).thenReturn(new Future.value(expectedResponse));
      var response = await balancesApi.retrieve(currency);
      verify(mockClient.get(uri, body: {})).called(1);
      expect(response, expectedResponse);
    });
  });
}
