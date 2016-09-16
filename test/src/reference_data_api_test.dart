library currency_cloud.reference_data_api_test;

import 'dart:async';

import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'mock_client.dart';
import 'package:currency_cloud/currency_cloud.dart';

main() {
  group('reference data api', () {
    ReferenceDataApi referenceDataApi;
    MockClient mockClient;

    setUp(() {
      mockClient = new MockClient();
      referenceDataApi = new ReferenceDataApi(mockClient);
      referenceDataApi.client = mockClient;
    });

    test('call to beneficiaryRequiredDetails without arguments should do according GET call', () async {
      var uri = '/reference/beneficiary_required_details';

      when(mockClient.get(any, body: any)).thenReturn(new Future.value('Someanswer'));
      await referenceDataApi.beneficiaryRequiredDetails();
      verify(mockClient.get(uri)).called(1);
    });

    test('call to beneficiaryRequiredDetails with arguments should do according GET call', () async {
      var uri = '/reference/beneficiary_required_details';

      when(mockClient.get(any, body: any)).thenReturn(new Future.value('Someanswer'));
      await referenceDataApi.beneficiaryRequiredDetails(
          currency: 'EUR', bankAccountCountry: 'AT', beneficiaryCountry: 'DE');
      verify(mockClient.get(uri, body: {'currency': 'EUR', 'bankAccountCountry': 'AT', 'beneficiaryCountry': 'DE'}))
          .called(1);
    });
  });
}
