import 'package:ai_safety_observation/presentation/viewmodels/upload_progress_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/video_submission.dart';
import '../../di/video_repository_provider.dart';
import '../../core/failure.dart';

part 'home_viewmodel.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<List<VideoSubmission>> build() async {
    final repo = ref.watch(videoRepositoryProvider);
    final result = await repo.getAllVideoRecords();
    return result.fold((f) => throw f, (r) => r);
  }

  Future<void> captureAndSync() async {
    state = const AsyncLoading();
    final repo = ref.read(videoRepositoryProvider);

    final result = await repo.captureAndStore();
    await _handleVideoRecordResult(result);
  }

  Future<void> pickAndSync() async {
    state = const AsyncLoading();
    final repo = ref.read(videoRepositoryProvider);

    final result = await repo.pickAndStore();
    await _handleVideoRecordResult(result);
  }

  Future<void> _handleVideoRecordResult(Either<Failure, VideoSubmission> result) async {
    final repo = ref.read(videoRepositoryProvider);

    result.fold((f) => state = AsyncError(f, StackTrace.current), (video) async {
      final fresh = await repo.getAllVideoRecords();
      state = fresh.fold((f) => AsyncError(f, StackTrace.current), (r) => AsyncData(r));
      await simulateUpload(video.path);
    });
  }

  Future<void> delete(VideoSubmission video) async {
    final repo = ref.read(videoRepositoryProvider);
    final result = await repo.deleteVideo(video);
    result.fold((f) => state = AsyncError(f, StackTrace.current), (_) async {
      final list = await repo.getAllVideoRecords();
      state = list.fold((f) => AsyncError(f, StackTrace.current), (r) => AsyncData(r));
    });
  }

  Future<void> simulateUpload(String path) async {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      ref.read(uploadProgressProvider.notifier).state = i / 10;
    }
    await Future.delayed(const Duration(milliseconds: 300));
    ref.read(uploadProgressProvider.notifier).state = 0.0;
  }
}
