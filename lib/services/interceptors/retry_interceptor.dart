import 'dart:io';

import 'package:dio/dio.dart';
import 'package:download_file_dio/services/interceptors/dio_connectifity_retrier.dart';
import 'package:flutter/material.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    @required this.requestRetrier,
  });

  @override
  Future onError(DioError error) async {
    if (_shouldRetry(error)) {
      try {
        return requestRetrier.scheduleRequestRetry(error.request);
      } catch (err) {
        return err;
      }
    }

    return error;
  }

  bool _shouldRetry(DioError error) {
    return error.type == DioErrorType.DEFAULT &&
        error.error != null &&
        error.error is SocketException;
  }
}
