import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/gallery_datasource.dart';

part 'gallery_datasource_provider.g.dart';

@riverpod
GalleryDataSource galleryDatasource(ref) {
  return GalleryDataSourceImpl();
}
