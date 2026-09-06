import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/taikhoan_lookup_model.dart';
import '../../../data/repository/taikhoan_repository.dart';

final taiKhoanLookupProvider = FutureProvider.family<List<TaiKhoanLookupModel>, LoaiTaiKhoan>((ref, type) async {
  switch (type) {
    case LoaiTaiKhoan.khoND:
      return await ref.read(taiKhoanRepositoryProvider).getKhoND();
    case LoaiTaiKhoan.maXL0:
      return await ref.read(taiKhoanRepositoryProvider).getMaXL0();
    case LoaiTaiKhoan.tkNoPx:
      return await ref.read(taiKhoanRepositoryProvider).getTKNoPx();
    case LoaiTaiKhoan.tkCoPx:
      return await ref.read(taiKhoanRepositoryProvider).getTKCoPx();
    case LoaiTaiKhoan.soCai:
      return await ref.read(taiKhoanRepositoryProvider).getTKSoCai();
  }
}, retry: (_, _) => null);
