import 'package:dio/dio.dart';

class PredictionService {
  final Dio _dio = Dio();
  final String _baseUrl ="https://a937-197-38-135-169.ngrok-free.app/predict_Text" ;

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
