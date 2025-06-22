import 'package:hive/hive.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_submission_model.freezed.dart';
part 'video_submission_model.g.dart';

@freezed
@HiveType(typeId: 0, adapterName: 'VideoSubmissionModelAdapter')
class VideoSubmissionModel with _$VideoSubmissionModel {
  const factory VideoSubmissionModel({
    @HiveField(0) required String path,
    @HiveField(1) required DateTime timestamp,
    @HiveField(2) required String title,
    @HiveField(3) required String notes,
  }) = _VideoSubmissionModel;

  factory VideoSubmissionModel.fromJson(Map<String, dynamic> json) =>
      _$VideoSubmissionModelFromJson(json);
}
