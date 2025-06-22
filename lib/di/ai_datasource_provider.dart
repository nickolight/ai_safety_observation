import 'package:ai_safety_observation/di/secure_storage_datasource_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/datasources/ai_datasource.dart';
import '../data/datasources/google_ai_datasource.dart';
import 'package:dio/dio.dart';

part 'ai_datasource_provider.g.dart';

@riverpod
AIDataSource aiDatasource(ref) {
  final storage = ref.watch(secureStorageDatasourceProvider);
  return GoogleAIDataSource(dio: Dio(), storage: storage, isMockMode: true);
}
