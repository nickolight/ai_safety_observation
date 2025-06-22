import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_annotation_model.freezed.dart';
part 'ai_annotation_model.g.dart';

@freezed
class AIAnnotationModel with _$AIAnnotationModel {
  const factory AIAnnotationModel({
    required String label,
    required Duration startTimestamp,
    required Duration endTimestamp,
  }) = _AIAnnotationModel;

  factory AIAnnotationModel.fromJson(Map<String, dynamic> json) =>
      _$AIAnnotationModelFromJson(json);
}
