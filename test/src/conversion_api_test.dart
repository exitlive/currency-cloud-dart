part of currency_cloud.test;

conversion_api_test() {
  group(('conversion api test'), () {
    ConversionsApi conversionApi;
    MockClient mockClient;
    AuthToken authToken;

    setUp(() {
      mockClient = new MockClient();
      authToken = new AuthToken();
      conversionApi = new ConversionsApi(authToken);
      conversionApi.client = mockClient;
    });

    test('call to detailed with all parameters set to valid values', () async {
      var buyCurrency = 'EUR';
      var sellCurrency = 'GBP';
      var fixedSide = FixedSide.buy;
      var amount = '38.00';
      var reason = 'Want to buy';
      var termAgreement = true;

      var expectedResponse = {
        "settlement_cut_off_time": "2014-10-07T14:00:00Z",
        "currency_pair": "EURGBP",
        "client_buy_currency": "EUR",
        "client_sell_currency": "GBP",
        "client_buy_amount": "10000.00",
        "client_sell_amount": "7826.00",
        "fixed_side": "buy",
        "mid_market_rate": "0.7824",
        "client_rate": "0.7826",
        "partner_rate": "",
        "core_rate": "0.7826",
        "deposit_required": null,
        "deposit_amount": "0.0",
        "deposit_currency": "GBP"
      };

      var requestBody = {
        'buy_currency': buyCurrency,
        'sell_currency': sellCurrency,
        'fixed_side': fixedSide.toString().split('.').last,
        'amount': amount,
        'reason': reason,
        'term_agreement': termAgreement.toString()
      };

      var uri = '/conversions/create';

      when(mockClient.post(any, body: any)).thenReturn(new Future.value(expectedResponse));
      var response = await conversionApi.create(buyCurrency, sellCurrency, fixedSide, amount, reason, termAgreement);
      expect(response, expectedResponse);
      verify(mockClient.post(uri, body: requestBody)).called(1);
    });
  });
}
