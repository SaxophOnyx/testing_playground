import 'package:core/core.dart';

import '../../../../../data.dart';

class ApiProvider {
  final Dio _dio;

  final String _listResultField;

  const ApiProvider({
    required Dio dio,
    required String listResultField,
  })  : _dio = dio,
        _listResultField = listResultField;

  Future<T> fetchObject<T>({
    required ApiRequest request,
    required T Function(Map<String, dynamic> data) parser,
  }) async {
    final dynamic data = await _request(request: request);
    return parser(data);
  }

  Future<List<T>> fetchList<T>({
    required ApiRequest request,
    required T Function(Map<String, dynamic> data) parser,
    String? listResultField,
  }) async {
    final dynamic data = await _request(request: request);
    final String dataField = listResultField ?? _listResultField;
    final List<dynamic> list = data is List ? data : data[dataField];
    return list.map((dynamic e) => parser(e as Map<String, dynamic>)).cast<T>().toList();
  }

  Future<T> fetchRaw<T>({
    required ApiRequest request,
  }) async {
    final dynamic data = await _request(request: request);
    return data;
  }

  Future<void> fetchNone({
    required ApiRequest request,
  }) async {
    await _request(request: request);
  }

  Future<dynamic> _request({
    required ApiRequest request,
  }) async {
    try {
      final Response<dynamic> response = await _dio.request(
        request.url,
        data: request.body,
        queryParameters: request.params,
        options: Options(
          method: request.method.key,
          headers: request.headers,
        ),
      );

      return response.data;
    } catch (e) {
      throw AppException(message: e.toString());
    }
  }
}
