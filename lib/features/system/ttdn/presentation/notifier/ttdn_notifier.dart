import 'dart:async';

import 'package:erp_client_1/features/system/ttdn/data/model/ttdn_model.dart';
import 'package:erp_client_1/features/system/ttdn/data/repository/ittdn_repository.dart';
import 'package:erp_client_1/features/system/ttdn/data/repository/ttdn_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ttdnProvider = AsyncNotifierProvider(TTDNNotifier.new, retry: (_,_)=>null);

class TTDNNotifier extends AsyncNotifier<List<TTDNModel>> {
  ITTDNRepository get _repo => ref.read(ttdnRepositoryProvider);

  @override
  FutureOr<List<TTDNModel>> build() async {
    // TODO: implement build
    return await _repo.getView();
  }

  Future<void> updateNoiDung(String noiDung, int id) async {
    try{
      final result = await _repo.updateNoiDung(noiDung, id);
      if (result > 0) {
        state = state.whenData((data) {
          return data.map((e) {
            if (e.id == id) {
              return e.copyWith(noiDung: noiDung);
            }
            return e;
          }).toList();
        });
      }
    }catch(e){
      rethrow;
    }

  }
}
