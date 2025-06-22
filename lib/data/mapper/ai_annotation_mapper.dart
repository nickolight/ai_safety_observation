import '../../domain/entities/ai_annotation.dart';
import '../models/ai_annotation_model.dart';

extension AIAnnotationMapper on AIAnnotationModel {
  AIAnnotation toEntity() => AIAnnotation(
    label: label,
    startTimestamp: startTimestamp,
    endTimestamp: endTimestamp,
  );
}
