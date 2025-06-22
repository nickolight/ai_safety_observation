import 'package:flutter_riverpod/flutter_riverpod.dart';

final uploadProgressProvider = StateProvider.autoDispose<double>((ref) => 0.0);
