part of currency_cloud;

class BalancesApi extends CurrencyCloudApi {
  BalancesApi(client) : super(client);

  Future<Map<String, dynamic>> retrieve(Currency currency) async {
    var url = '/balances/${currency.code.toUpperCase()}';
    return await client.get(url, body: {});
  }
}
