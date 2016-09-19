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

    var bankAccountHolderName = 'John Doe';
    var bankCountry = 'GB';
    var currencyCode = 'GBP';
    var currency = new Currency(currencyCode);
    var name = 'Employee Funds';

    var email = 'john.doe@acme.com';
    var beneficiaryAddress = '23 Acacia Road';
    var beneficiaryCountry = 'GB';
    var accountNumber = '3284734675';
    var routingCodeType1 = 'aba';
    var routingCodeValue1 = '011103093';
    var routingCodeType2 = 'bsb_code';
    var routingCodeValue2 = '088';
    var bicSwift = 'DABADKKK';
    var iban = 'AD1200012030200359100100';
    var defaultBeneficiary = true;
    var bankAddress = '4356 Wisteria Lane';
    var bankName = 'HSBC Bank';
    var bankAccountType = 'checking';
    var beneficiaryEntityType = 'individual';
    var beneficiaryCompanyName = 'Some Company LLC';
    var beneficiaryFirstName = 'John';
    var beneficiaryLastName = 'Doe';
    var beneficiaryCity = 'London';
    var beneficiaryPostcode = 'W11 2BQ';
    var beneficiaryStateOrProvince = 'TX';
    var beneficiaryDateOfBirth = '2010-10-10';
    var beneficiaryIdentificationType = 'drivers_license';
    var beneficiaryIdentificationValue = 'AE02315508BF';
    var paymentTypes = 'priority';
    var onBehalfOf = '6188410c-44bf-41d4-810f-8a766c3035b0';

    setUp(() {
      mockClient = new MockClient();
      beneficiariesApi = new BeneficiariesApi(mockClient);
      beneficiariesApi.client = mockClient;
    });

    test('call with minimum amount of parameters should cause according post call', () async {
      var answer = {'much_answer': 'very_custom'};
      when(mockClient.post(any, body: any)).thenReturn(new Future.value(answer));
      var result = await beneficiariesApi.create(bankAccountHolderName, bankCountry, currency, name);

      var uri = '/beneficiaries/create';
      var body = {
        'bank_account_holder_name': bankAccountHolderName,
        'bank_country': bankCountry,
        'currency': currencyCode,
        'name': name
      };

      verify(mockClient.post(uri, body: body)).called(1);
      expect(result, answer);
    });

    test('call with maximum amount of parameters should cause according post call', () async {
      var answer = {'much_answer': 'very_custom'};
      when(mockClient.post(any, body: any)).thenReturn(new Future.value(answer));
      var result = await beneficiariesApi.create(bankAccountHolderName, bankCountry, currency, name,
          email: email,
          beneficiaryAddress: beneficiaryAddress,
          beneficiaryCountry: beneficiaryCountry,
          accountNumber: accountNumber,
          routingCodeType1: routingCodeType1,
          routingCodeValue1: routingCodeValue1,
          routingCodeType2: routingCodeType2,
          routingCodeValue2: routingCodeValue2,
          bicSwift: bicSwift,
          iban: iban,
          defaultBeneficiary: defaultBeneficiary,
          bankAddress: bankAddress,
          bankName: bankName,
          bankAccountType: bankAccountType,
          beneficiaryEntityType: beneficiaryEntityType,
          beneficiaryCompanyName: beneficiaryCompanyName,
          beneficiaryFirstName: beneficiaryFirstName,
          beneficiaryLastName: beneficiaryLastName,
          beneficiaryCity: beneficiaryCity,
          beneficiaryPostcode: beneficiaryPostcode,
          beneficiaryStateOrProvince: beneficiaryStateOrProvince,
          beneficiaryDateOfBirth: beneficiaryDateOfBirth,
          beneficiaryIdentificationType: beneficiaryIdentificationType,
          beneficiaryIdentificationValue: beneficiaryIdentificationValue,
          paymentTypes: paymentTypes,
          onBehalfOf: onBehalfOf);

      var uri = '/beneficiaries/create';
      var body = {
        'bank_account_holder_name': bankAccountHolderName,
        'bank_country': bankCountry,
        'currency': currencyCode,
        'name': name,
        'email': 'john.doe@acme.com',
        'beneficiary_address': '23 Acacia Road',
        'beneficiary_country': 'GB',
        'account_number': '3284734675',
        'routing_code_type_1': 'aba',
        'routing_code_value_1': '011103093',
        'routing_code_type_2': 'bsb_code',
        'routing_code_value_2': '088',
        'bic_swift': 'DABADKKK',
        'iban': 'AD1200012030200359100100',
        'default_beneficiary': true,
        'bank_address': '4356 Wisteria Lane',
        'bank_name': 'HSBC Bank',
        'bank_account_type': 'checking',
        'beneficiary_entity_type': 'individual',
        'beneficiary_company_name': 'Some Company LLC',
        'beneficiary_first_name': 'John',
        'beneficiary_last_name': 'Doe',
        'beneficiary_city': 'London',
        'beneficiary_postcode': 'W11 2BQ',
        'beneficiary_state_or_province': 'TX',
        'beneficiary_date_of_birth': '2010-10-10',
        'beneficiary_identification_type': 'drivers_license',
        'beneficiary_identification_value': 'AE02315508BF',
        'payment_types': 'priority',
        'on_behalf_of': '6188410c-44bf-41d4-810f-8a766c3035b0',
      };

      verify(mockClient.post(uri, body: body));
      expect(result, answer);
    });
  });
}
