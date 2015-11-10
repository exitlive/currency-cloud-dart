part of currency_cloud;

class PaymentsApi extends CurrencyCloudApi {
  PaymentsApi(authToken) : super(authToken);

  Future<Map<String, String>> create(Money money, String beneficiaryId, String reason, String reference) {
    var uri = '/payments/create';

    var body = {};
    body['amount'] = money.amountAsString;
    body['currency'] = money.currency.code;
    body['beneficiary_id'] = beneficiaryId;
    body['reason'] = reason;
    body['reference'] = reference;

    return client.post(uri, body: body);
  }
}
