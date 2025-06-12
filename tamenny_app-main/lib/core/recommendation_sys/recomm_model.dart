import 'package:tflite_flutter/tflite_flutter.dart';

class DiseasePriorityModel {
  late Interpreter _interpreter;

  final List<String> labels = ['heart', 'brain', 'lung', 'knee', 'neutral'];

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset("assets/Ai_models/disease_recommendation_model5.tflite");
  }

  Future<List<double>> predict(List<double> inputFeatures) async {
    var input = [inputFeatures];
    var output = List.filled(5, 0.0).reshape([1, 5]);

    _interpreter.run(input, output);

    return List<double>.from(output[0]);
  }

  Future<Map<String, double>> predictWithLabels(List<double> inputFeatures) async {
    final scores = await predict(inputFeatures);

    return Map.fromIterables(labels, scores);
  }
}
