import 'package:erp_client_1/features/danhmuc/thuesuat/data/model/thuesuat_model.dart';
import 'package:erp_client_1/features/danhmuc/thuesuat/data/repository/thuesuat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final thueSuatLookupProvider = FutureProvider<List<ThueSuatModel>>((ref) async {
  final data = await ref.read(thueSuatRepositoryProvider).getLookup();
  return data;
});
