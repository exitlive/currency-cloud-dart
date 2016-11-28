// Copyright (c) 2015, Daniel Domberger. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

/// The currency_cloud library.
///
/// Dart library for the CurrencyCloud service
library currency_cloud;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:money/money.dart';

export 'package:money/money.dart';

part 'src/base/currency_cloud_base.dart';
part 'src/api/authenticate.dart';
part 'src/api/rates.dart';
part 'src/api/balances.dart';
part 'src/api/conversion.dart';
part 'src/api/reference_data.dart';
part 'src/api/beneficiaries.dart';
part 'src/api/payments.dart';

final Logger log = new Logger('CurrencyCloud');

/// [CurrencyCloud] is the Class that provides the Interface for external calls. Using this library
/// starts by getting a [CurrencyCloud] instance and calling the API methods one wants to use on that.
class CurrencyCloud {
  CurrencyCloudClient client;

  // Public viewable APIs according to CurrencyCloud Docs
  AuthenticateApi _authApi;
  AuthenticateApi get authApi => _authApi;

  RatesApi _ratesApi;
  RatesApi get ratesApi => _ratesApi;

  ConversionsApi _conversionApi;
  ConversionsApi get conversionApi => _conversionApi;

  BalancesApi _balancesApi;
  BalancesApi get balancesApi => _balancesApi;

  ReferenceDataApi _referenceDataApi;
  ReferenceDataApi get referenceDataApi => _referenceDataApi;

  BeneficiariesApi _beneficiariesApi;
  BeneficiariesApi get beneficiariesApi => _beneficiariesApi;

  PaymentsApi _paymentsApi;
  PaymentsApi get paymentsApi => _paymentsApi;

  /// Provide true for [useLiveUri] if you want to use this client in production and trigger real money transfers
  CurrencyCloud(String loginId, String apiKey, {bool useLiveUri: false}) {
    client = new CurrencyCloudClient(loginId, apiKey, useLiveUri: useLiveUri);

    // Initialize all APIs
    _authApi = new AuthenticateApi(client);
    _ratesApi = new RatesApi(client);
    _conversionApi = new ConversionsApi(client);
    _balancesApi = new BalancesApi(client);
    _referenceDataApi = new ReferenceDataApi(client);
    _beneficiariesApi = new BeneficiariesApi(client);
    _paymentsApi = new PaymentsApi(client);
  }
}
