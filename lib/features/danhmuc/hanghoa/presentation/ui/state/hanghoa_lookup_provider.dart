import 'package:erp_client_1/features/danhmuc/hanghoa/data/model/hanghoa_lookup_model.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/data/repository/hanghoa_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hangHoaLookupProvider = FutureProvider<List<HangHoaLookupModel>>((ref) async {
  final data = await ref.read(hangHoaRepositoryProvider).getLookup();
  return data;
});
