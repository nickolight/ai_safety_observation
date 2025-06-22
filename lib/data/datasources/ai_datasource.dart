import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../models/ai_annotation_model.dart';

abstract class AIDataSource {
  Future<Either<Failure, List<AIAnnotationModel>>> analyzeVideo(String path);
}
