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
  final String baseUri = 'https://devapi.thecurrencycloud.com/v2';
  AuthToken _authToken;

  CurrencyCloudClient(this._authToken);

  /// Sets auth headers in provided [headers] and sends HTTP GET request to
  /// given [uri] with [body] set as encoded uri parameters.
  Future<Map<String, String>> get(String uri, {Map<String, String> body, Map<String, String> headers}) async {
    uri = baseUri + uri;

    headers = _setAuthHeader(headers);

    if (body != null) {
      // list of the uri parameters to be set
      var params = [];
      for (var key in body.keys) {
        params.add('$key=${body[key]}');
      }

      uri += '?';
      uri += params.join('&');
      uri = Uri.encodeFull(uri);
    }

    log.finest('Sending GET request with HEADERS: ' + headers.toString());
    log.finest('to URL: ' + uri);
    var response = await http.get(uri, headers: headers);

    return _decodeResponse(response);
  }

  /// Sets auth headers in provided [headers] and sends HTTP POST request to
  /// given [methodUrl].
  Future<Map<String, String>> post(String methodUrl, {Map<String, String> body, Map<String, String> headers}) async {
    final String url = baseUri + methodUrl;

    headers = _setAuthHeader(headers);
    body ??= {};

    log.finest('Sending post request to url: $url');
    log.finest('headers: ${headers.toString()}');
    log.finest('body: ${body.toString()}');
    var response = await http.post(url, headers: headers, body: body);

    return _decodeResponse(response);
  }

  Map<String, String> _decodeResponse(http.Response response) {
    Map<String, String> responseBody = JSON.decode(response.body);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw new CurrencyCloudException(response.statusCode, responseBody);
    }

    if (responseBody.containsKey('error_code')) {
      throw new CurrencyCloudException(response.statusCode, responseBody);
    }

    return responseBody;
  }

  /// Returns a new copy of given [headers] with the 'X-Auth-Token' header set if authToken has been set before. If [headers]
  /// is not being provided returns a [headers] Map only containing of the set 'X-Auth-Token'.
  Map<String, String> _setAuthHeader([Map<String, String> headers]) {
    headers ??= {};
    var newHeaders = new Map.from(headers);

    if (_authToken.isSet) {
      newHeaders['X-Auth-Token'] = _authToken.value;
    }

    return newHeaders;
  }
}

class CurrencyCloudException implements Exception {
  int statusCode;
  Map<String, String> body;

  CurrencyCloudException(this.statusCode, this.body);

  toString() => 'CurrencyCloudException(${statusCode}): ${body.toString()}';
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

enum FixedSide { buy, sell }
enum PaymentType { regular, priority }