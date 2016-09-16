part of currency_cloud;

/// Base Class for all Currency Cloud APIs (according to Currency Cloud documented APIs)
/// Every API has to get the same instance of AuthToken, which is the only shared
/// information between all instances of [CurrencyCloudApi].
abstract class CurrencyCloudApi {
  CurrencyCloudClient client;

  CurrencyCloudApi(this.client);
}

/// [CurrencyCloudClient] is used for communication with the CurrencyCloudService. It provides Request methods
/// like [get] and [post] which handle the basic communication overheads like adding authentication headers.
class CurrencyCloudClient {
  static final String devUri = 'https://devapi.thecurrencycloud.com/v2';
  static final String liveUri = 'https://api.thecurrencycloud.com/v2';

  final String baseUri;

  String loginId, apiKey;

  final AuthToken _authToken = new AuthToken();
  bool get isAuthenticated => _authToken.isSet;

  /// Provide true for [useLiveUri] if you want to use this client in production and trigger real money transfers
  CurrencyCloudClient(this.loginId, this.apiKey, {bool useLiveUri: false}) : baseUri = useLiveUri ? liveUri : devUri;

  /// Sets auth headers in provided [headers] and sends HTTP GET request to
  /// given [uri] with [body] set as encoded uri parameters.
  Future<Map<String, dynamic>> get(String uri, {Map<String, String> body, Map<String, String> headers}) async {
    uri = baseUri + uri;

    headers = await _setAuthHeader(headers);

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
    var responseMap;

    try {
      responseMap = _decodeResponse(response);
    } on AuthException {
      log.finest('Got AuthException, reauthenticating');
      await authenticate();
      headers = await _setAuthHeader(headers);

      response = await http.get(uri, headers: headers);
      responseMap = _decodeResponse(response);
    }

    return responseMap;
  }

  /// Sets auth headers in provided [headers] and sends HTTP POST request to
  /// given [methodUrl].
  Future<Map<String, dynamic>> post(String methodUrl, {Map<String, String> body, Map<String, String> headers}) async {
    final String url = baseUri + methodUrl;

    headers = await _setAuthHeader(headers);
    body ??= {};

    var response, responseMap;

    log.finest('Sending post request to url: $url');
    log.finest('headers: ${headers.toString()}');
    log.finest('body: ${body.toString()}');
    response = await http.post(url, headers: headers, body: body);

    try {
      responseMap = _decodeResponse(response);
    } on AuthException {
      await authenticate();
      headers = await _setAuthHeader(headers);

      response = await http.post(url, headers: headers, body: body);
      responseMap = _decodeResponse(response);
    }

    return responseMap;
  }

  /// Authenticates this [CurrencyCloud] using its [loginId] and [apiKey]. [CurrencyCloud] will authenticate
  /// automatically if a Request is sent without authenticating or when the Authentication Token expires.
  authenticate() async {
    var authUri = baseUri + '/authenticate/api';

    var body = {
      'login_id': loginId,
      'api_key': apiKey,
    };

    log.finest('Sending authentication request to url: $authUri');
    log.finest('body: $body');

    var response;
    response = await http.post(authUri, body: body);
    response = _decodeResponse(response);

    log.finest('Got response Token: $response["auth_token"]');

    _authToken.value = response['auth_token'];
  }

  /// Closes authenticated Session
  closeSession() async {
    var uri = baseUri + '/authenticate/close_session';

    await http.post(uri);
    _authToken.reset;
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    var responseBody = JSON.decode(response.body);
    if (!(responseBody is Map)) {
      log.finest('Decoded response body was not a json map');
      throw new CurrencyCloudException(response.statusCode, responseBody);
    }
    if (responseBody.containsKey('error_code')) {
      log.finest('error_code is: ' + responseBody['error_code']);
      if (responseBody['error_code'] == 'auth_failed') {
        log.finest('throw AuthException');
        throw new AuthException(response.statusCode, responseBody);
      }
      log.finest('throw CurrencyCloudException');
      throw new CurrencyCloudException(response.statusCode, responseBody);
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw new CurrencyCloudException(response.statusCode, responseBody);
    }

    return responseBody;
  }

  /// Returns a new copy of given [headers] with the 'X-Auth-Token' header set if authToken has been set before. If
  /// [headers] is not being provided returns a [headers] Map only containing the set 'X-Auth-Token'.
  Future<Map<String, String>> _setAuthHeader([Map<String, String> headers]) async {
    headers ??= {};
    var newHeaders = new Map.from(headers);

    if (_authToken.isSet) {
      newHeaders['X-Auth-Token'] = _authToken.value;
    } else {
      await authenticate();
      newHeaders['X-Auth-Token'] = _authToken.value;
    }

    return newHeaders;
  }
}

class CurrencyCloudException implements Exception {
  final String name = 'CurrencyCloudException';
  final int statusCode;
  final Map<String, String> body;
  final String requestUri;

  CurrencyCloudException(this.statusCode, this.body, {this.requestUri});

  toString() => '$name (${statusCode}): ${body.toString()}';
}

class AuthException extends CurrencyCloudException {
  final String name = 'AuthException';

  AuthException(int statusCode, Map<String, String> body) : super(statusCode, body);
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
