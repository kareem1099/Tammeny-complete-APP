import 'package:dio/dio.dart';

class PredictionService {
  final Dio _dio = Dio();
  final String _baseUrl ="https://4f68-197-38-123-89.ngrok-free.app/predict_Text" ;

  Future<String?> predict(String text) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: FormData.fromMap({'text': text}),

      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }
}
