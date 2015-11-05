// Copyright (c) 2015, Daniel Domberger. All rights reserved. Use of this source code
// is governed by a MIT-style license that can be found in the LICENSE file.

/// The currency_cloud library.
///
/// Dart library for the CurrencyCloud service
library currency_cloud;

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'dart:async';
import 'dart:convert';

part 'src/currency_cloud_base.dart';
part 'src/authenticate_api.dart';
part 'src/rates_api.dart';

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

  CurrencyCloud() {
    setupLogging();

    _authToken = new AuthToken();

    _authApi = new AuthenticateApi(_authToken);
    _ratesApi = new RatesApi(_authToken);
  }
}

setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

}
