import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DioClient {
  final Dio _dio = Dio();
  final Ref ref;
  DioClient(this.ref);

  Future<Response> get(String url) async {
    try {
      return await _dio.get(url);
    } catch (e) {
      throw Exception(e);
    }
  }
}

final dioProvider = Provider<DioClient>((ref) => DioClient(ref));
