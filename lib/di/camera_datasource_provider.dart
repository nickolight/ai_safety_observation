import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/camera_datasource.dart';

part 'camera_datasource_provider.g.dart';

@riverpod
CameraDataSource cameraDatasource(ref) {
  return CameraDataSourceImpl();
}
