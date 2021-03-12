import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:download_file_dio/services/interceptors/dio_connectifity_retrier.dart';
import 'package:download_file_dio/services/interceptors/retry_interceptor.dart';
import 'package:download_file_dio/utils/april_url.dart';
import 'package:flutter/foundation.dart';

class Api {
  Api() {
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true));
    }
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: Dio(),
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  static BaseOptions options = new BaseOptions(
    baseUrl: '$baseUrl/employee',
  );
  final Dio dio = Dio(options);

  Future<Response<dynamic>> wrapE(
      Future<Response<dynamic>> Function() dioApi) async {
    try {
      return await dioApi();
    } catch (error) {
      if (error is DioError && error.type == DioErrorType.RESPONSE) {
        final Response<dynamic> response = error.response;
        final String errorMessage =
            'Code ${response.statusCode} - ${response.statusMessage}';
        throw DioError(
          request: error.request,
          response: error.response,
          type: error.type,
          error: errorMessage,
        );
      }
      rethrow;
    }
  }
}
