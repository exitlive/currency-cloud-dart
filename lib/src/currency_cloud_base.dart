library currency_cloud.base;

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

class CurrencyCloud {
  final String baseUrl = 'https://devapi.thecurrencycloud.com/v2';
  final Logger log = new Logger('CurrencyCloud');

  var _authToken;

  static var _instance;

  static getInstance() {
    return _instance ??= new CurrencyCloud._internal();
  }

  CurrencyCloud._internal() {}

  /// Authenticates this [CurrencyCloud] using given [loginId] and [apiKey]. This [CurrencyCloud] instance can
  /// only be used after authentication.
  authenticate(String loginId, String apiKey) async {
    // Make sure we are in unauthenticated state
    _authToken = null;

    var url = '/authenticate/api';
    var body = {};
    body['login_id'] = loginId;
    body['api_key'] = apiKey;

    await _sendApiRequest(url, body: body);

    _authToken = body['auth_token'];
  }

  _sendApiRequest(String methodUrl, {Map body}) async {
    final String url = baseUrl + methodUrl;

    body ??= {};

    if(_authToken != null) {
      body['auth_token'] = _authToken;
    }

    return http.post(url, body: body).then((response) {
      final responseBody = JSON.decode(response.body);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        log.severe('There was a Problem with a CurrencyCloud API request to ${url}');
        log.finest('${response.body}');
        throw new CurrencyCloudException('Request returned ');
      } else {
        log.finest('Response body: ' + response.body.toString());
      }

      return responseBody;
    });
  }
}

class CurrencyCloudException implements Exception {
  String name;
  String msg;
  String code;

  CurrencyCloudException(this.msg);
}

abstract class CurrencyCloudRequest {
  var url;

  call() {}
}
