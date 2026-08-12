import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/ithu_repository.dart';
import '../../data/repository/thu_repository.dart';

final thuUpdateEditProvider = AsyncNotifierProvider.autoDispose(ThuUpdateEditNotifier.new, retry: (_, _) => null);

class ThuUpdateEditNotifier extends AsyncNotifier<void> {
  IThuRepository get _repo => ref.read(thuRepositoryProvider);

  @override
  FutureOr<void> build() {
    // TODO: implement build
    throw UnimplementedError();
  }

  Future<void> updateEdit(int id) async {
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repo.updateEdit(id);
    });
  }
}
