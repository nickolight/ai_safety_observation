import 'package:hive/hive.dart';

part 'video_submission_hive_model.g.dart';

@HiveType(typeId: 0)
class VideoSubmissionHiveModel extends HiveObject {
  @HiveField(0)
  final String path;

  @HiveField(1)
  final DateTime timestamp;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String notes;

  VideoSubmissionHiveModel({
    required this.path,
    required this.timestamp,
    required this.title,
    required this.notes,
  });
}
