import 'package:erp_client_1/features/ketchuyen/data/model/buttoan_model.dart';
import 'package:erp_client_1/features/ketchuyen/data/repository/ketchuyen_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final butToanLookupProvider = FutureProvider<List<ButToanModel>>((ref) async {
  final repo = ref.read(ketChuyenRepositoryProvider);
  return await repo.getLookupButToan();
});
