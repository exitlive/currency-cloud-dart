library currency_cloud.beneficiaries_api_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:money/money.dart';

import 'package:currency_cloud/currency_cloud.dart';
import 'mock_client.dart';

main() {
  group('BeneficiariesApi', () {
    BeneficiariesApi beneficiariesApi;
    MockClient mockClient;
    var currencyISO = 'EUR';
    var iban = 'DE89370400440532013000';
    var bicSwift = 'COBADEFF';

    var bankAccountHolderName = 'Gandalf The White';
    var bankCountry = 'middle-earth';
    var currency = new Currency(currencyISO);
    var name = 'Anti Mordor Foundation Funds';

    setUp(() {
      mockClient = new MockClient();
      beneficiariesApi = new BeneficiariesApi(mockClient);
      beneficiariesApi.client = mockClient;
    });

    test('call with minimum amount of parameters should cause according post call', () async {
      var answer = {'much_answer': 'very_custom'};
      when(mockClient.post(any, body: any)).thenReturn(new Future.value(answer));
      var result = await beneficiariesApi.create(bankAccountHolderName, bankCountry, currency, name,
          iban: iban, bicSwift: bicSwift);

      var uri = '/beneficiaries/create';
      var body = {
        'bank_account_holder_name': bankAccountHolderName,
        'bank_country': bankCountry,
        'currency': currencyISO,
        'name': name,
        'iban': iban,
        'bic_swift': bicSwift
      };

      verify(mockClient.post(uri, body: body)).called(1);
      expect(result, answer);
    });
  });
}
