import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/repositories/video_repository.dart';
import '../data/repositories/video_repository_impl.dart';
import 'camera_datasource_provider.dart';
import 'gallery_datasource_provider.dart';
import 'compression_datasource_provider.dart';
import 'local_storage_datasource_provider.dart';
import 'ai_datasource_provider.dart';

part 'video_repository_provider.g.dart';

@riverpod
VideoRepository videoRepository(ref) {
  return VideoRepositoryImpl(
    camera: ref.watch(cameraDatasourceProvider),
    gallery: ref.watch(galleryDatasourceProvider),
    compressor: ref.watch(compressionDatasourceProvider),
    storage: ref.watch(localStorageDatasourceProvider),
    ai: ref.watch(aiDatasourceProvider),
  );
}
