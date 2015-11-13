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
    AuthToken authToken;

    setUp(() {
      mockClient = new MockClient();
      authToken = new AuthToken();
      referenceDataApi = new ReferenceDataApi(authToken);
      referenceDataApi.client = mockClient;
    });

    test('call to beneficiaryRequiredDetails without arguments should do according GET call', () async {
      var uri = '/reference/beneficiary_required_details';

      when(mockClient.get(any, body: any)).thenReturn(new Future.value('Someanswer'));
      await referenceDataApi.beneficiaryRequiredDetails();
      verify(mockClient.get(uri)).called(1);
    });
  });
}