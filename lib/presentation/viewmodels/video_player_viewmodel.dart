import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/ai_annotation.dart';
import '../../di/video_repository_provider.dart';

part 'video_player_viewmodel.g.dart';

@riverpod
Future<List<AIAnnotation>> videoPlayerViewModel(ref, String path) async {
  final repo = ref.watch(videoRepositoryProvider);
  final result = await repo.analyzeVideo(path);
  return result.fold((f) => throw f, (r) => r);
}
