part of currency_cloud;

final Logger log = new Logger('CurrencyCloud');

abstract class CurrencyCloudApi {
  final String baseUrl = 'https://devapi.thecurrencycloud.com/v2';

  AuthToken _authToken;

  CurrencyCloudApi(this._authToken);

  /// Sets auth headers in provided [headers] and sends HTTP GET request to
  /// given methodUrl. Beware [headers] are being modified!
  _get(String methodUrl, {Map<String, String> headers}) async {
    final String url = baseUrl + methodUrl;

    _setAuthHeader(headers);

    return await http.get(url, headers: headers);
  }

  _post(String methodUrl, {Map body, Map<String, String> headers}) async {
    final String url = baseUrl + methodUrl;

    _setAuthHeader(headers);
    body ??= {};

    return await http.post(url, headers: headers, body: body);
  }

  /// Sets the 'X-Auth-Token' header in a given Map of [headers] if authToken has been set before. If [headers]
  /// is not being provided returns a [headers] Map only containing of the set 'X-Auth-Token'.
  _setAuthHeader([Map<String, String> headers]) {
    headers ??= {};

    if (_authToken.isSet) {
      headers['X-Auth-Token'] = _authToken.value;
    }

    return headers;
  }
}

class CurrencyCloud {
  AuthToken authToken;

  var authenticate;

  CurrencyCloud() {
    authToken = new AuthToken();
    authenticate = new AuthenticateApi(authToken);
  }
}

class CurrencyCloudRequest {
  var url;

  send() {
    // _get or _post
    // return parse JSON.decode(response.body);
  }
}

class CurrencyCloudResponse {}

class CurrencyCloudException implements Exception {
  String name;
  String msg;
  String code;

  CurrencyCloudException(this.msg);
}

class AuthToken {
  String _value;
  String get value => _value;
  bool get isSet => _value != null;
}
