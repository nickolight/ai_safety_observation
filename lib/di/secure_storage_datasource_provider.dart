import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/secure_storage_datasource.dart';

part 'secure_storage_datasource_provider.g.dart';

@riverpod
SecureStorageDataSource secureStorageDatasource(ref) {
  return SecureStorageDataSourceImpl();
}
