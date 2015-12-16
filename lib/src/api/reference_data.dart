part of currency_cloud;

class ReferenceDataApi extends CurrencyCloudApi {
  ReferenceDataApi(authToken) : super(authToken);

  Future<Map<String, String>> beneficiaryRequiredDetails() {
    var uri = '/reference/beneficiary_required_details';

    return client.get(uri);
  }
}
