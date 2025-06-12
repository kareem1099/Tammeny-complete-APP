import 'dart:developer';

import 'package:dio/dio.dart';

class MedicalNewsApiService {
  final Dio dio;
  MedicalNewsApiService(this.dio);
  Future<Map<String, dynamic>> get(String category) async {
    String Url  ;
    final categories = ['heart', 'brain', 'lung', 'knee'];

    if (category == categories[0]) {
      Url =
      "https://newsapi.org/v2/everything?q=heart+disease&language=en&sortBy=publishedAt&pageSize=10&apiKey=bba3b46c6fab407abcbd859e48939016";
    } else if (category == categories[1]) {
      Url =
      "https://newsapi.org/v2/everything?q=brain+disease+OR+brain+tumor+OR+brain+health&language=en&sortBy=publishedAt&pageSize=10&apiKey=bba3b46c6fab407abcbd859e48939016";
    } else if (category == categories[2]) {
      Url =
      "https://newsapi.org/v2/everything?q=lung+disease+OR+lung+cancer&language=en&sortBy=publishedAt&pageSize=10&apiKey=bba3b46c6fab407abcbd859e48939016";
    } else if (category == categories[3]) {
      Url =
      "https://newsapi.org/v2/everything?q=knee+pain+OR+knee+injury&language=en&sortBy=publishedAt&pageSize=10&apiKey=bba3b46c6fab407abcbd859e48939016";
    } else {
      Url =
      "https://newsapi.org/v2/everything?q=medical+health+news&language=en&sortBy=publishedAt&pageSize=10&apiKey=bba3b46c6fab407abcbd859e48939016";
    }

    var response = await dio.get(Url);
    log('API response: ${response.data.toString()}');

    return response.data;

  }
}
