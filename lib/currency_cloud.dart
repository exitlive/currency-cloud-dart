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

part 'src/currency_cloud_base.dart';
part 'src/authenticate_api.dart';
part 'src/rates_api.dart';
part 'src/conversion_api.dart';
part 'src/reference_data_api.dart';
part 'src/beneficiaries_api.dart';

final Logger log = new Logger('CurrencyCloud');

/// [CurrencyCloud] is the Class that provides the Interface for external calls. Using this library
/// starts by getting a [CurrencyCloud] instance and calling the API methods one wants to use on that.
class CurrencyCloud {
  AuthToken _authToken;

  bool get isAuthenticated => _authToken.isSet;

  // Public viewable APIs according to CurrencyCloud Docs
  AuthenticateApi _authApi;
  AuthenticateApi get authApi => _authApi;

  RatesApi _ratesApi;
  RatesApi get ratesApi => _ratesApi;

  ConversionsApi _conversionApi;
  ConversionsApi get conversionApi => _conversionApi;

  ReferenceDataApi _referenceDataApi;
  ReferenceDataApi get referenceDataApi => _referenceDataApi;

  BeneficiariesApi _beneficiariesApi;
  BeneficiariesApi get beneficiariesApi => _beneficiariesApi;

  CurrencyCloud() {
    setupLogging();

    _authToken = new AuthToken();

    _authApi = new AuthenticateApi(_authToken);
    _ratesApi = new RatesApi(_authToken);
    _conversionApi = new ConversionsApi(_authToken);
    _referenceDataApi = new ReferenceDataApi(_authToken);
    _beneficiariesApi = new BeneficiariesApi(_authToken);
  }
}

setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
