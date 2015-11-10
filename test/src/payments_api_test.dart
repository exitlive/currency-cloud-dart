library currency_cloud.payments_api_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

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

    test('create() should call client.post() with correct body and return result', () async {
      var uri = '/payments/create';
      var currencyISO = 'EUR';
      Money money = new Money(5000, new Currency(currencyISO));
      var beneficiaryId = 'funkyId';
      var reason = 'somereason';
      var reference = 'somereference';

      var body = {};
      body['currency'] = currencyISO;
      body['amount'] = '50.00';
      body['beneficiary_id'] = beneficiaryId;
      body['reason'] = reason;
      body['reference'] = reference;

      var answer = {'custom': 'answer'};
      when(mockClient.post(any, body: any)).thenReturn(new Future.value(answer));
      var result = await paymentsApi.create(money, beneficiaryId, reason, reference);

      verify(mockClient.post(uri, body: body)).called(1);
      expect(result, answer);
    });
  });
}