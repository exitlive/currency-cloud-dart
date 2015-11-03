part of currency_cloud;

class RatesApi extends CurrencyCloudApi {
  RatesApi(authToken) : super(authToken);

  Map<String, String> detailed(String buyCurrency, String sellCurrency, fixedSide, String amount,
      {String onBehalfOf, DateTime conversionDate}) async {

    var url = '/rates/detailed';

    var body = new Map<String, String>();
    body['buy_currency'] = buyCurrency;
    body['sell_currency'] = sellCurrency;
    body['fixed_side'] = fixedSide;
    body['amount'] = amount;

    if (onBehalfOf != null) body['on_behalf_of'] = onBehalfOf;
    if (conversionDate != null) body['conversion_date'] = conversionDate.toString();

    return await client.post(url, body: body);
  }
}
