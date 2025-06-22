import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/local_storage_datasource.dart';

part 'local_storage_datasource_provider.g.dart';

@riverpod
LocalStorageDataSource localStorageDatasource(ref) {
  return LocalStorageDataSourceImpl();
}
