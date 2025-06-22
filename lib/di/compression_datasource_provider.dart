import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/compression_datasource.dart';

part 'compression_datasource_provider.g.dart';

@riverpod
CompressionDataSource compressionDatasource(ref) {
  return CompressionDataSourceImpl();
}
