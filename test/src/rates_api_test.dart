library currency_cloud.rates_api_test;

import 'dart:async';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:currency_cloud/currency_cloud.dart';

import 'mock_client.dart';

main() {
  group('rates', () {
    RatesApi ratesApi;
    MockClient mockClient;
    AuthToken authToken;

    setUp(() {
      mockClient = new MockClient();
      authToken = new AuthToken();
      ratesApi = new RatesApi(authToken);
      ratesApi.client = mockClient;
    });

    test('call to detailed with all parameters set to valid values', () async {
      var buyCurrency = 'EUR';
      var sellCurrency = 'GBP';
      var fixedSide = 'buy';
      var amount = '38.00';

      var response = {
        "settlement_cut_off_time": "2014-10-07T14:00:00Z",
        "currency_pair": "EURGBP",
        "client_buy_currency": "EUR",
        "client_sell_currency": "GBP",
        "client_buy_amount": "10000.00",
        "client_sell_amount": "7826.00",
        "fixed_side": "buy",
        "mid_market_rate": "0.7824",
        "client_rate": "0.7826",
        "partner_rate": "",
        "core_rate": "0.7826",
        "deposit_required": null,
        "deposit_amount": "0.0",
        "deposit_currency": "GBP"
      };

      var requestBody = {
        'buy_currency': buyCurrency,
        'sell_currency': sellCurrency,
        'fixed_side': fixedSide,
        'amount': amount
      };

      var uri = '/rates/detailed';

      when(mockClient.get(any, body: any)).thenReturn(new Future.value(response));
      await ratesApi.detailed(buyCurrency, sellCurrency, fixedSide, amount);
      verify(mockClient.get(uri, body: requestBody)).called(1);
    });
  });
}
