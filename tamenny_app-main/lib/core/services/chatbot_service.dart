import 'package:dio/dio.dart';

class chatService {
  final Dio _dio = Dio();
  final String baseUrl= 'https://a937-197-38-135-169.ngrok-free.app';



  Future<String?> getChatbotResponse(String text) async {
    try {
      final response = await _dio.post(
        '$baseUrl/chatbot',
        data: FormData.fromMap({'text': text}),
      );
      return response.data['response'];
    } catch (e) {
      throw("Chatbot Error: $e");
    }
  }
}
