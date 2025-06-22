import 'package:ai_safety_observation/domain/entities/video_submission.dart';
import '../models/video_submission_hive_model.dart';

/// from Hive -> Domain
extension HiveToDomain on VideoSubmissionHiveModel {
  VideoSubmission toEntity() =>
      VideoSubmission(path: path, timestamp: timestamp, title: title, notes: notes);
}

/// from Domain -> Hive
extension DomainToHive on VideoSubmission {
  VideoSubmissionHiveModel toHiveModel() =>
      VideoSubmissionHiveModel(path: path, timestamp: timestamp, title: title, notes: notes);
}
