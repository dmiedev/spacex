abstract class _SpacexApiClientException implements Exception {
  const _SpacexApiClientException();
}

/// An exception that occurs while making an `http` request.
class HttpException extends _SpacexApiClientException {}

/// An exception that occurs if a server responded on a request with a non-200
/// status code.
class HttpRequestException extends _SpacexApiClientException {
  /// Creates an exception that occurs if a server responded on a request with
  /// a non-200 status code.
  const HttpRequestException(this.statusCode);

  /// The status code of the response.
  final int statusCode;
}

/// An exception that occurs while decoding an `http` response body.
class JsonDecodeException extends _SpacexApiClientException {}

/// An exception that occurs while deserializing a JSON map.
class JsonDeserializationException extends _SpacexApiClientException {}
