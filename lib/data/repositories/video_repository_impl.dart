import 'package:ai_safety_observation/data/mapper/ai_annotation_mapper.dart';
import 'package:ai_safety_observation/data/models/video_submission_hive_model.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import '../../core/failure.dart';
import '../../domain/entities/video_submission.dart';
import '../../domain/entities/ai_annotation.dart';
import '../../domain/repositories/video_repository.dart';
import '../datasources/camera_datasource.dart';
import '../datasources/gallery_datasource.dart';
import '../datasources/compression_datasource.dart';
import '../datasources/local_storage_datasource.dart';
import '../datasources/ai_datasource.dart';
import '../mapper/video_submission_mapper.dart';

class VideoRepositoryImpl implements VideoRepository {
  final CameraDataSource camera;
  final GalleryDataSource gallery;
  final CompressionDataSource compressor;
  final LocalStorageDataSource storage;
  final AIDataSource ai;

  VideoRepositoryImpl({
    required this.camera,
    required this.gallery,
    required this.compressor,
    required this.storage,
    required this.ai,
  });

  @override
  Future<Either<Failure, VideoSubmission>> captureAndStore() async {
    try {
      final file = await camera.captureVideo();
      if (file == null) return left(StorageFailure("No video captured"));
      final compressed = await compressor.compressVideo(file);

      final entity = VideoSubmission(
        path: compressed.path,
        timestamp: DateTime.now(),
        title: compressed.path.split('/').last,
        notes: '',
      );

      await storage.saveSubmission(entity.toHiveModel());
      return right(entity);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, VideoSubmission>> pickAndStore() async {
    try {
      final file = await gallery.pickVideoFromGallery();
      if (file == null) return left(StorageFailure("No video selected"));
      final compressed = await compressor.compressVideo(file);

      final entity = VideoSubmission(
        path: compressed.path,
        timestamp: DateTime.now(),
        title: compressed.path.split('/').last,
        notes: '',
      );

      await storage.saveSubmission(entity.toHiveModel());
      return right(entity);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoSubmission>>> getAllVideoRecords() async {
    try {
      final list = await storage.getSubmissions();
      return right(list.map((h) => h.toEntity()).toList());
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AIAnnotation>>> analyzeVideo(String path) async {
    final result = await ai.analyzeVideo(path);
    return result.map((list) => list.map((m) => m.toEntity()).toList());
  }

  @override
  Future<Either<Failure, Unit>> deleteVideo(VideoSubmission entity) async {
    try {
      final box = await Hive.openBox<VideoSubmissionHiveModel>('video_submissions');
      final item = box.values.firstWhere((v) => v.path == entity.path);
      await item.delete();
      return right(unit);
    } catch (e) {
      return left(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> simulateUpload(String path) async {
    try {
      for (int i = 0; i <= 10; i++) {
        await Future.delayed(const Duration(milliseconds: 300));
      }
      return right(1.0); // 100%
    } catch (e) {
      return left(StorageFailure("Upload simulation failed"));
    }
  }

}
