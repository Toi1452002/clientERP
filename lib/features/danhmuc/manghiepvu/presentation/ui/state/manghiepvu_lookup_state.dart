import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/repository/manghiepvu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final maNghiepVuLookupProvider = FutureProvider.family<List<MaNghiepVuModel>, KieuNghiepVu>((ref, kieu) async {
  switch (kieu) {
    case KieuNghiepVu.thu:
      return await ref.read(maNghiepVuRepositoryProvider).getT();
    case KieuNghiepVu.chi:
      return await ref.read(maNghiepVuRepositoryProvider).getC();
    case KieuNghiepVu.nhap:
      return await ref.read(maNghiepVuRepositoryProvider).getN();
    case KieuNghiepVu.xuat:
      return await ref.read(maNghiepVuRepositoryProvider).getX();

  }
}, retry: (_,_)=>null);
