[ ![Codeship Status for exitlive/currency_cloud](https://codeship.com/projects/6ac792d0-5ba5-0133-4261-42612c8c8541/status?branch=master)](https://codeship.com/projects/110767)

# currency_cloud

A dart library for the [Currency Cloud](https://developer.currencycloud.com/) service

## Usage

A simple usage example resembling [Cookbook from Currency Cloud docs](https://developer.currencycloud.com/documentation/getting-started/cookbook/):
```dart
    import 'dart:async';
    
    import 'package:currency_cloud/currency_cloud.dart';

    main() async {
      var cc = new CurrencyCloud();
      
      // 1. Authenticate
      await cc.authApi.authenticate(loginId, apiKey);
      
      // 2. Get a Quote
      var buyCurrency = new Currency('EUR');
      var sellCurrency = new Currency('GBP');
      var fixedSide = FixedSide.buy;
      var amount = '1000.00';
      
      var result = await cc.ratesApi.detailed(buyCurrency, sellCurrency, fixedSide, amount);
      
      // 3. Convert
      var reason = 'Invoice Payment';
      var termAgreement = true;
      
      var conversion =
          await cc.conversionApi.create(buyCurrency, sellCurrency, fixedSide, amount, reason, termAgreement);
          
      // 4. Add a Beneficiary
      var bankAccountHolderName = 'Acme GmbH';
      var bankCountry = 'DE';
      var currency = new Currency('EUR');
      var name = '';
      var iban = 'DE89370400440532013000';
      var bicSwift = 'COBADEFF';
      
      var beneficiary = await cc.beneficiariesApi
          .create(bankAccountHolderName, bankCountry, currency, name, iban: iban, bicSwift: bicSwift);
      
      // 5. Pay
      var money = new Money.fromString(amount, buyCurrency);
      var reference = 'Invoice 1234';
      
      var result = await cc.paymentsApi.create(money, beneficiary['id'], reason, reference,
          conversionId: conversion['id']);
    }
```
