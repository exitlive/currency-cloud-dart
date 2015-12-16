part of currency_cloud;

class BeneficiariesApi extends CurrencyCloudApi {
  BeneficiariesApi(authToken) : super(authToken);

  Future<Map<String, String>> create(String bankAccountHolderName, String bankCountry, Currency currency, String name,
      {String iban, String, bicSwift}) {
    var uri = '/beneficiaries/create';

    var body = {
      'bank_account_holder_name': bankAccountHolderName,
      'bank_country': bankCountry,
      'currency': currency.code,
      'name': name,
      'iban': iban,
      'bic_swift': bicSwift,
    };

    return client.post(uri, body: body);
  }
}
