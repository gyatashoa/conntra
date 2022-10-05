import 'package:contra/service/api_service.dart';
import 'package:contra/service/cloud_firestore_service.dart';
import 'package:contra/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future registerServices() async {
  getIt.registerSingleton<ApiService>(ApiService(Dio(BaseOptions(
      headers: {'Accept': 'application/json'}, followRedirects: false))));
  getIt.registerSingleton<CloudFirestoreService>(CloudFirestoreService());
  getIt.registerSingletonAsync<StorageService>(() async {
    final storageService = StorageService();
    await storageService.init();
    return storageService;
  });
}
