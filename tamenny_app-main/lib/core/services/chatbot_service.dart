import 'package:dio/dio.dart';

class chatService {
  final Dio _dio = Dio();
  final String baseUrl= 'https://4f68-197-38-123-89.ngrok-free.app';



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
