import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spacex_api/src/exceptions.dart';
import 'package:spacex_api/src/models/models.dart';

/// A Dart API client for the unofficial open-source SpaceX REST API.
class SpacexApiClient {
  /// Creates a Dart API client for the unofficial open-source SpaceX REST API.
  SpacexApiClient({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  static const _authority = 'api.spacexdata.com';

  final http.Client _httpClient;

  /// Queries SpaceX rocket launches using the specified [filter] and pagination
  /// [options].
  Future<Page<Launch>> queryLaunches({
    Filter filter = const Filter.empty(),
    PaginationOptions options = const PaginationOptions(),
  }) {
    final url = Uri.https(_authority, '/v5/launches/query');
    return _query<Launch>(url, filter, options);
  }

  /// Queries SpaceX rockets using the specified [filter] and pagination
  /// [options].
  Future<Page<Rocket>> queryRockets({
    Filter filter = const Filter.empty(),
    PaginationOptions options = const PaginationOptions(),
  }) {
    final url = Uri.https(_authority, '/v4/rockets/query');
    return _query<Rocket>(url, filter, options);
  }

  /// Fetches all SpaceX rockets.
  Future<List<Rocket>> fetchAllRockets() async {
    final url = Uri.https(_authority, '/v4/rockets');
    final jsonList = await _get<List<dynamic>>(url);
    try {
      return jsonList
          .map((item) => Rocket.fromJson(item as Map<String, dynamic>))
          .toList();
    } on Exception {
      throw JsonDeserializationException();
    }
  }

  /// Fetches information about the SpaceX company.
  Future<Company> fetchCompany() async {
    final url = Uri.https(_authority, '/v4/company');
    final json = await _get<Map<String, dynamic>>(url);
    try {
      return Company.fromJson(json);
    } on Exception {
      throw JsonDeserializationException();
    }
  }

  Future<Page<T>> _query<T>(
    Uri url,
    Filter filter,
    PaginationOptions options,
  ) async {
    final requestBody = {
      'query': filter.toJson(),
      'options': options.toJson(),
    };
    final json = await _post<Map<String, dynamic>>(url, requestBody);
    try {
      return Page.fromJson<T>(json);
    } on Exception {
      throw JsonDeserializationException();
    }
  }

  Future<T> _post<T>(Uri url, Map<String, dynamic> body) {
    return _sendRequest<T>(() => _httpClient.post(url, body: body));
  }

  Future<T> _get<T>(Uri url) {
    return _sendRequest<T>(() => _httpClient.get(url));
  }

  Future<T> _sendRequest<T>(
    Future<http.Response> Function() sendCallback,
  ) async {
    http.Response response;
    try {
      response = await sendCallback();
    } on Exception {
      throw HttpException();
    }
    if (response.statusCode != 200) {
      throw HttpRequestException(response.statusCode);
    }
    try {
      return json.decode(response.body) as T;
    } on Exception {
      throw JsonDecodeException();
    }
  }
}
