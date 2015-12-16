part of currency_cloud;

class ConversionsApi extends CurrencyCloudApi {
  ConversionsApi(client) : super(client);

  // TODO use package:Money instead of Strings
  Future<Map<String, String>> create(String buyCurrency, String sellCurrency, FixedSide fixedSide, String amount,
      String reason, bool termAgreement) async {
    var url = '/conversions/create';

    var body = {
      'buy_currency': buyCurrency,
      'sell_currency': sellCurrency,
      'fixed_side': fixedSide.toString().split('.').last,
      'amount': amount,
      'reason': reason,
      'term_agreement': termAgreement.toString()
    };

    return await client.post(url, body: body);
  }
}
