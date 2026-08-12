import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/khach_edit_model.dart';
import '../../data/model/khach_request_model.dart';
import '../../data/repository/ikhach_repository.dart';
import '../../data/repository/khach_repository.dart';

final khachEditProvider = AsyncNotifierProvider.autoDispose(KhachEditNotifier.new);

class KhachEditNotifier extends AsyncNotifier<void> {
  IKhachRepository get repo => ref.read(khachRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> addKhach(KhachRequestModel khach) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repo.add(khach);
    });
  }
  Future<void> updateKhach(KhachRequestModel khach, int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repo.update(khach, id);
    });
  }
  Future<KhachEditModel> getById(int id) async{
    return await repo.getById(id);
  }
}
