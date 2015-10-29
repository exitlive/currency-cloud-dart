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

final Logger log = new Logger('CurrencyCloud');

class CurrencyCloud {
  AuthToken _authToken;

  bool get isAuthenticated => _authToken.isSet;

  // Public viewable APIs according to CurrencyCloud Docs
  AuthenticateApi authApi;

  CurrencyCloud() {
    _authToken = new AuthToken();
    authApi = new AuthenticateApi(_authToken);
  }
}
