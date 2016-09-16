part of currency_cloud;

class RatesApi extends CurrencyCloudApi {
  RatesApi(client) : super(client);

  // TODO use package:Money instead of Strings
  Future<Map<String, dynamic>> detailed(String buyCurrency, String sellCurrency, fixedSide, String amount) async {
    var url = '/rates/detailed';

    var body = {
      'buy_currency': buyCurrency,
      'sell_currency': sellCurrency,
      'fixed_side': fixedSide,
      'amount': amount,
    };

    return await client.get(url, body: body);
  }
}
