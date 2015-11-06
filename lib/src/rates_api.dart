part of currency_cloud;

class RatesApi extends CurrencyCloudApi {
  RatesApi(authToken) : super(authToken);

  Future<Map<String, String>> detailed(String buyCurrency, String sellCurrency, fixedSide, String amount) async {
    var url = '/rates/detailed';

    var body = new Map<String, String>();
    body['buy_currency'] = buyCurrency;
    body['sell_currency'] = sellCurrency;
    body['fixed_side'] = fixedSide;
    body['amount'] = amount;

    return await client.get(url, body: body);
  }
}
