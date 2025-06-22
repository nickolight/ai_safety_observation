import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/failure.dart';
import '../models/ai_annotation_model.dart';
import '../datasources/ai_datasource.dart';
import '../datasources/secure_storage_datasource.dart';

class GoogleAIDataSource implements AIDataSource {
  final Dio dio;
  final SecureStorageDataSource storage;
  final bool isMockMode;

  GoogleAIDataSource({
    required this.dio,
    required this.storage,
    this.isMockMode = false,
  });

  @override
  Future<Either<Failure, List<AIAnnotationModel>>> analyzeVideo(String path) async {
    try {
      if (isMockMode) {
        await Future.delayed(const Duration(seconds: 2));

        final mockAnnotations = <AIAnnotationModel>[
          AIAnnotationModel(
            label: "Helmet",
            startTimestamp: const Duration(seconds: 2),
            endTimestamp: const Duration(seconds: 5),
          ),
          AIAnnotationModel(
            label: "Construction site",
            startTimestamp: const Duration(seconds: 6),
            endTimestamp: const Duration(seconds: 10),
          ),
        ];

        return right(mockAnnotations);
      }

      final token = await storage.readToken();
      if (token == null) return left(ServerFailure("Token is missing"));

      final requestBody = {
        "inputUri": path,
        "features": ["LABEL_DETECTION"],
      };

      final response = await dio.post(
        "https://videointelligence.googleapis.com/v1/videos:annotate?key=$token",
        data: jsonEncode(requestBody),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      // TODO: add real response parsing

      return right([]);
    } catch (e) {
      return left(ServerFailure("Unexpected error: ${e.toString()}"));
    }
  }
}
