import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dioFormData;

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://alwakar.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    // String lang = 'en',
    required String? token,
  }) async {
    dio!.options.headers = {
      // 'lang': lang,
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }

  addFormDataToJson({fileKey = 'image', file, jsonObject}) async {
    jsonObject[fileKey] = await dioFormData.MultipartFile.fromFile(
      file.path,
      filename: file.path.split('/').last,
    );
    return dioFormData.FormData.fromMap(jsonObject);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    // String lang = 'en',
    String? token,
    String headers = 'application/json',
  }) async {
    dio!.options.headers = {
      'Content-Type': headers,
     'Authorization': 'Bearer $token',
      'X-Requested-With': 'XMLHttpRequest',
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'X-Requested-With': 'XMLHttpRequest',
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
