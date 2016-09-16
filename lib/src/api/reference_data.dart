part of currency_cloud;

class ReferenceDataApi extends CurrencyCloudApi {
  ReferenceDataApi(client) : super(client);

  /// Returns required beneficiary details and their basic validation formats
  /// [currency] is the currency of the beneficiary bank account
  /// [bankAccountCountry] is the country of the beneficiary bank account
  /// [beneficiaryCountry] is the nationality of the beneficiary
  Future<Map<String, dynamic>> beneficiaryRequiredDetails(
      {String currency, String bankAccountCountry, String beneficiaryCountry}) {
    var uri = '/reference/beneficiary_required_details';
    var body = {};
    if (currency != null) body['currency'] = currency;
    if (bankAccountCountry != null) body['bankAccountCountry'] = bankAccountCountry;
    if (beneficiaryCountry != null) body['beneficiaryCountry'] = beneficiaryCountry;
    if (body.isEmpty) {
      return client.get(uri);
    } else {
      return client.get(uri, body: body);
    }
  }
}
