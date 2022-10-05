import 'dart:developer';

import 'package:contra/constants/api.dart';
import 'package:contra/model/category.dart';
import 'package:contra/model/news.dart';
import 'package:contra/model/prediction.dart';
import 'package:contra/model/product.dart';
import 'package:contra/model/user.dart';
import 'package:contra/service/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ApiService {
  late Dio _dio;

  ApiService(Dio dio) {
    _dio = dio;
  }

  Future login({required String email, required String password}) async {
    try {
      Response res = await _dio.post('${API_BASE_URL}login',
          data: {'login': email, 'password': password});
      if (res.statusCode == null) throw Exception('Invalid status code');
      String? msg = _getErrorMsg(res.statusCode!);
      //TODO: return user details here
      if (msg == null) {
        final data = User.fromJson(res.data['data']);
        await GetIt.instance<StorageService>().saveUser(data);
        return data;
      }
      return msg;
    } on DioError catch (e) {
      if (e.response?.data["errors"] == null) {
        return 'Error logging in';
      }
      return Map<String, dynamic>.from(e.response?.data["errors"])
          .values
          .map((e) => e.toString())
          .toList();
    } on Exception {
      return 'An error while trying to signup';
    }
  }

  Future getProducts({required String token}) async {
    try {
      Response res = await _dio.get(
        '${API_BASE_URL}products',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      return (Map<String, dynamic>.from(res.data)['data'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
    } on DioError catch (e) {
      return 'Error connecting to backend';
    } on Exception {
      return 'Error getting products';
    }
  }

  Future<List<News>> getNews() async {
    var res = await _dio.get(NEWS_API_URL + NEWS_API_KEY);
    return (res.data['articles'] as List).map((e) => News.fromJson(e)).toList();
  }

  Future getProductsForACategory(
      {required String token, required Category category}) async {
    try {
      Response res = await _dio.get(
        '${API_BASE_URL}categories/${category.categoryId}',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      return (Map<String, dynamic>.from(res.data)['data']['products'] as List)
          .map((e) => Product.fromJson({...e, 'category': category.toJson}))
          .toList();
    } on DioError catch (e) {
      return 'Error connecting to backend';
    } on Exception {
      return 'Error getting products';
    }
  }

  Future getLocation(String placeName) async {
    try {
      String mapKey = 'AIzaSyChlSYajoQ0gJ0tBW-_ViE5ACej3fdcn1o';
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$mapKey&sessiontoken=123254251&components=country:gh';
      var res = await _dio.get(url);
      if (res.statusCode == 200) {
        var predictionJson = res.data['predictions'];
        return (predictionJson as List)
            .map((e) => Prediction.fromJson(e))
            .toList();
      }
      return 'Error getting location';
    } on DioError {
      return 'Error getting location';
    } on Exception {
      return 'Error getting location';
    }
  }

  Future getProduct({required String token, required Product product}) async {
    try {
      Response res = await _dio.get(
        '${API_BASE_URL}products/${product.id}',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      return Product.fromJson(Map<String, dynamic>.from(res.data)['data']);
    } on DioError catch (e) {
      return 'Error connecting to backend';
    } on Exception {
      return 'Error getting products';
    }
  }

  Future getCategories({required String token}) async {
    try {
      Response res = await _dio.get(
        '${API_BASE_URL}categories',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      return (Map<String, dynamic>.from(res.data)['data'] as List)
          .map((e) => Category.fromJson(e))
          .toList();
    } on DioError catch (e) {
      print(e.message);
      throw e;
    }
  }

  Future signUp(User user, String confirmPassword) async {
    try {
      Response res = await _dio.post('${API_BASE_URL}register',
          data: {...user.toJson, 'password_confirmation': confirmPassword});
      if (res.statusCode == null) throw Exception('Invalid status code');
      String? msg = _getErrorMsg(res.statusCode!);
      //TODO: return user details here
      if (msg == null) {
        final data = User.fromJson(res.data['data']);
        await GetIt.instance<StorageService>().saveUser(data);
        return data;
      }
      return msg;
    } on DioError catch (e) {
      return Map<String, dynamic>.from(e.response?.data["errors"])
          .values
          .map((e) => e.toString())
          .toList();
    } on Exception {
      return 'An error while trying to signup';
    }
  }

  Future<void> logout() async {
    await GetIt.instance<StorageService>().deleteUser();
  }

  String? _getErrorMsg(int statusCode) {
    switch (statusCode) {
      case 200:
        return null;
      case 201:
        return null;
      case 400:
        return 'Bad request';
      case 404:
        return 'Url not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Error connecting to api';
    }
  }
}
