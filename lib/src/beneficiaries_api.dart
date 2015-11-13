part of currency_cloud;

class BeneficiariesApi extends CurrencyCloudApi {
  BeneficiariesApi(authToken) : super(authToken);

  Future<Map<String, String>> create(String bankAccountHolderName, String bankCountry, Currency currency, String name,
      {String iban, String, bicSwift}) {
    var uri = '/beneficiaries/create';

    var body = {};
    body['bank_account_holder_name'] = bankAccountHolderName;
    body['bank_country'] = bankCountry;
    body['currency'] = currency.code;
    body['name'] = name;
    body['iban'] = iban;
    body['bic_swift'] = bicSwift;

    return client.post(uri, body: body);
  }
}
