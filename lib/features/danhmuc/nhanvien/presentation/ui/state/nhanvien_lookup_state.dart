import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_lookup_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/nhanvien_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nhanVienLookupProvider = FutureProvider<List<NhanVienLookupModel>>((ref) async {
  final data = ref.read(nhanVienRepositoryProvider).getLookup();
  return data;
});
