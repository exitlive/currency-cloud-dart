@Skip("Don't run integration tests by default")
library currency_cloud.integration_test;

import 'package:test/test.dart';

import 'package:currency_cloud/currency_cloud.dart';
import '../config/config.dart';

import 'package:logging/logging.dart';

main() {
  group('integration tests', () {
    CurrencyCloud cc;
    var loginId;
    var apiKey;
    var log;

    var bankAccountHolderName;
    var bankCountry;
    var currency;
    var name;
    var iban;
    var bicSwift;

    setUp(() {
      setupLogging();
      log = new Logger('IntegrationTests');

      loginId = Config.loginId;
      apiKey = Config.apiKey;

      cc = new CurrencyCloud(loginId, apiKey);

      bankAccountHolderName = 'Hansi';
      bankCountry = 'DE';
      currency = new Currency('EUR');
      name = 'Secret Funds';
      iban = 'DE89370400440532013000';
      bicSwift = 'COBADEFF';
    });

    test('authenticate call should set authToken', () async {
      expect(cc.client.isAuthenticated, false);
      await cc.authApi.authenticate();
      expect(cc.client.isAuthenticated, true);
    });

    test('ratesApi.detailed() call should return a quote', () async {
      var buyCurrency = 'EUR';
      var sellCurrency = 'GBP';
      var fixed_side = 'buy';
      var amount = '40.00';

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

      var result = await cc.conversionApi.create(buyCurrency, sellCurrency, fixed_side, amount, reason, termAgreement);

      expect(result['buy_currency'], buyCurrency);
      expect(result['sell_currency'], sellCurrency);
      expect(result['fixed_side'], fixed_side.toString().split('.').last);
      expect(result['client_buy_amount'], amount);
    });

    test('referenceDataApi.beneficiaryRequiredDetails() should return something without Errors', () async {
      var result = await cc.referenceDataApi.beneficiaryRequiredDetails();
      log.finest(result);
    });

    test('beneficiariesApi.create() and retrieve()', () async {
      var result = await cc.beneficiariesApi
          .create(bankAccountHolderName, bankCountry, currency, name, iban: iban, bicSwift: bicSwift);

      expect(result['bank_account_holder_name'], bankAccountHolderName);

      var beneficiaryId = result['id'];
      var retrieveResult = await cc.beneficiariesApi.retrieve(beneficiaryId);

      expect(retrieveResult['bank_account_holder_name'], bankAccountHolderName);
      expect(retrieveResult['bank_country'], bankCountry);
      expect(retrieveResult['currency'], currency.toString());
      expect(retrieveResult['name'], name);
      expect(retrieveResult['iban'], iban);
      expect(retrieveResult['bic_swift'], bicSwift);
    });

    test('paymentsApi.create()', () async {
      var money = new Money(5000, new Currency('EUR'));
      var reason = 'SomeReason';
      var reference = 'INVOICE 12348';
      var paymentType = PaymentType.regular;

      var buyCurrency = 'EUR';
      var sellCurrency = 'EUR';
      var fixedSide = FixedSide.buy;
      var amount = money.amountAsString;
      var termAgreement = true;

      var conversion =
          await cc.conversionApi.create(buyCurrency, sellCurrency, fixedSide, amount, reason, termAgreement);
      var beneficiary = await cc.beneficiariesApi
          .create(bankAccountHolderName, bankCountry, currency, name, iban: iban, bicSwift: bicSwift);
      var result = await cc.paymentsApi.create(money, beneficiary['id'], reason, reference,
          conversionId: conversion['id'], paymentType: paymentType);
      log.finest(result);
    });
  });
}

setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
