import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'network_config.dart';
import 'network_service_interceptor.dart';

final apiUriProvider = FutureProvider<String>((ref) async {
  final file = File("Config/appsettings.json");
  final json = jsonDecode(await file.readAsString());
  return json["ApiUri"];
});

final networkServiceProvider = Provider<Dio>((ref) {
  final options = BaseOptions(
    baseUrl: NetworkConfig.apiUrl,
    // baseUrl: "https://localhost:7157/api",
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );

  final dio = Dio(options);
  final provider = ref.read(networkServiceInterceptorProvider);
  dio.interceptors.addAll([HttpFormatter(), provider]);

  return dio;
});