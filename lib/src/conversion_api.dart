part of currency_cloud;

class ConversionsApi extends CurrencyCloudApi {
  ConversionsApi(authToken) : super(authToken);

  Future<Map<String, String>> create(String buyCurrency, String sellCurrency, FixedSide fixedSide, String amount,
      String reason, bool termAgreement) async {
    var url = '/conversions/create';

    var body = new Map<String, String>();
    body['buy_currency'] = buyCurrency;
    body['sell_currency'] = sellCurrency;
    body['fixed_side'] = fixedSide.toString().split('.').last;
    body['amount'] = amount;
    body['reason'] = reason;
    body['term_agreement'] = termAgreement.toString();

    return await client.post(url, body: body);
  }
}
