@Skip("Don't run integration tests by default")
library currency_cloud.integration_test;

import 'package:test/test.dart';

import 'package:currency_cloud/currency_cloud.dart';
import '../../config/config.dart';

import 'package:logging/logging.dart';

main() {
  group('integration tests', () {
    CurrencyCloud cc;
    var loginId;
    var apiKey;
    var log;

    setUp(() {
      setupLogging();
      log = new Logger('IntegrationTests');

      loginId = Config.loginId;
      apiKey = Config.apiKey;

      cc = new CurrencyCloud();
    });

    test('authenticate call should set authToken', () async {
      expect(cc.isAuthenticated, false);
      await cc.authApi.authenticate(loginId, apiKey);
      expect(cc.isAuthenticated, true);
    });

    test('ratesApi.detailed() call should return a quote', () async {
      var buyCurrency = 'EUR';
      var sellCurrency = 'GBP';
      var fixed_side = 'buy';
      var amount = '40.00';

      await cc.authApi.authenticate(loginId, apiKey);
      var result = await cc.ratesApi.detailed(buyCurrency, sellCurrency, fixed_side, amount);

      expect(result['client_buy_currency'], buyCurrency);
      expect(result['client_sell_currency'], sellCurrency);
      expect(result['fixed_side'], fixed_side);
      expect(result['client_buy_amount'], amount);
    });

    test('conversionApi.create() call should return a ', () async {
      var buyCurrency = 'EUR';
      var sellCurrency = 'GBP';
      var fixed_side = FixedSide.buy;
      // TODO the amount of '40.00' seems to be too low. Find out if this is just a Demo problem
      var amount = '4000.00';
      var reason = 'whatever';
      var termAgreement = true;

      await cc.authApi.authenticate(loginId, apiKey);
      var result = await cc.conversionApi.create(buyCurrency, sellCurrency, fixed_side, amount, reason, termAgreement);

      expect(result['buy_currency'], buyCurrency);
      expect(result['sell_currency'], sellCurrency);
      expect(result['fixed_side'], fixed_side.toString().split('.').last);
      expect(result['client_buy_amount'], amount);
    });
    test('referenceDataApi.beneficiaryRequiredDetails() should return something without Errors', () async {
      await cc.authApi.authenticate(loginId, apiKey);
      var result = await cc.referenceDataApi.beneficiaryRequiredDetails();
      log.finest(result);
    });
  });
}
