import 'dart:io';
import 'package:dio/dio.dart';

class AIDiagnosisService {
  final Dio dio;
  final String baseUrl = 'https://a937-197-38-135-169.ngrok-free.app';
  AIDiagnosisService(this.dio);

  Future<Map<String, dynamic>> Diagnosis({
    required File imageFile,
    required String diagnosisTag,
  }) async {
    String url = '$baseUrl/predict_$diagnosisTag';

    String fileName = imageFile.path.split('/').last;

    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        imageFile.path,
        filename: fileName,
      ),
    });

    Response response = await dio.post(
      url,
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('error: ${response.statusCode}');
    }
  }

}





