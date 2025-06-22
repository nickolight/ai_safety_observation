import 'package:dartz/dartz.dart';
import '../../core/failure.dart';
import '../entities/video_submission.dart';
import '../entities/ai_annotation.dart';

abstract class VideoRepository {
  Future<Either<Failure, VideoSubmission>> captureAndStore();
  Future<Either<Failure, VideoSubmission>> pickAndStore();
  Future<Either<Failure, List<VideoSubmission>>> getAllVideoRecords();
  Future<Either<Failure, List<AIAnnotation>>> analyzeVideo(String videoPath);
  Future<Either<Failure, Unit>> deleteVideo(VideoSubmission entity);
  Future<Either<Failure, double>> simulateUpload(String path);
}
