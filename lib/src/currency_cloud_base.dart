part of currency_cloud;

/// Base Class for all Currency Cloud APIs (according to Currency Cloud documented APIs)
/// Every API has to get the same instance of AuthToken, which is the only shared
/// information between all instances of [CurrencyCloudApi].
abstract class CurrencyCloudApi {
  AuthToken _authToken;
  CurrencyCloudClient client;

  CurrencyCloudApi(this._authToken) {
    client = new CurrencyCloudClient(_authToken);
  }

  CurrencyCloudApi.withCurrencyCloudClient(this._authToken, this.client);
}

/// [CurrencyCloudClient] is used for communication with the CurrencyCloudService. It provides Request methods
/// like [get] and [post] which handle the basic communication overheads like adding authentication headers.
class CurrencyCloudClient {
  final String baseUrl = 'https://devapi.thecurrencycloud.com/v2';
  AuthToken _authToken;

  CurrencyCloudClient(this._authToken);

  /// Sets auth headers in provided [headers] and sends HTTP GET request to
  /// given methodUrl. Beware [headers] are being modified!
  get(String methodUrl, {Map<String, String> headers}) async {
    final String url = baseUrl + methodUrl;

    _setAuthHeader(headers);

    return await http.get(url, headers: headers);
  }

  Future<Map<String, String>> post(String methodUrl, {Map body, Map<String, String> headers}) async {
    final String url = baseUrl + methodUrl;

    _setAuthHeader(headers);
    body ??= {};

    var response = await http.post(url, headers: headers, body: body);
    var responseBody = JSON.decode(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw new CurrencyCloudException(response.statusCode, responseBody);
    }

    return responseBody;
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

class CurrencyCloudException implements Exception {
  int statusCode;
  Map<String, String> body;

  CurrencyCloudException(this.statusCode, this.body);
}

class AuthToken {
  String _value;
  String get value => _value;
  bool get isSet => _value != null;

  reset() {
    _value = null;
  }

  set value(String value) {
    log.finest('Setting AuthToken to $value');
    _value = value;
  }
}
