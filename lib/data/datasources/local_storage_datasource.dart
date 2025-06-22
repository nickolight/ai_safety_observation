import 'package:hive/hive.dart';
import '../models/video_submission_hive_model.dart';

abstract class LocalStorageDataSource {
  Future<void> saveSubmission(VideoSubmissionHiveModel model);
  Future<List<VideoSubmissionHiveModel>> getSubmissions();
  Future<void> deleteSubmission(VideoSubmissionHiveModel model);
}

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  static const String boxName = 'video_submissions';

  @override
  Future<void> saveSubmission(VideoSubmissionHiveModel model) async {
    final box = await Hive.openBox<VideoSubmissionHiveModel>(boxName);
    await box.add(model);
  }

  @override
  Future<List<VideoSubmissionHiveModel>> getSubmissions() async {
    final box = await Hive.openBox<VideoSubmissionHiveModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> deleteSubmission(VideoSubmissionHiveModel model) async {
    final box = await Hive.openBox<VideoSubmissionHiveModel>(boxName);
    await model.delete();
  }
}
