import 'package:contra/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerServices() {
  getIt.registerSingleton<ApiService>(ApiService(Dio(BaseOptions(
      headers: {'Accept': 'application/json'}, followRedirects: false))));
}
