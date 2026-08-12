import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/model/khach_lookup_model.dart';
import '../../../data/repository/khach_repository.dart';

final khachLookupProvider = FutureProvider.family<List<KhachLookupModel>, LoaiKH>((ref, loaiKH) async {
  switch (loaiKH){
    case LoaiKH.NhaCung:
      return await ref.read(khachRepositoryProvider).getNhaCung();
    case LoaiKH.Khach:
      return await ref.read(khachRepositoryProvider).getKhach();
  // default:
  //   return [];
  }
},retry: (_,_)=>null);