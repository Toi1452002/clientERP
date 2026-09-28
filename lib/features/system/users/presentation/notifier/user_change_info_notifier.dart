import 'dart:async';

import 'package:erp_client_1/features/system/auth/presentation/notifier/auth_notifier.dart';
import 'package:erp_client_1/features/system/users/data/model/user_changed_info_model.dart';
import 'package:erp_client_1/features/system/users/data/repository/iuser_repository.dart';
import 'package:erp_client_1/features/system/users/data/repository/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userChangedInfoProvider = AsyncNotifierProvider.autoDispose(UserChangeInfoNotifier.new, retry: (_, _) => null);

class UserChangeInfoNotifier extends AsyncNotifier<int> {
  IUserRepository get _repo => ref.read(userRepositoryProvider);

  @override
  FutureOr<int> build() {
    // TODO: implement build
    return 0;
  }

  Future<void> changed(UserChangedInfoModel model) async {
    if (model.oldUsername.isEmpty ||
        model.oldPassword.isEmpty ||
        model.newUsername.isEmpty ||
        model.newPassword.isEmpty ||
        model.confirmPassword.isEmpty) {
      state = AsyncError("Nhập đầy đủ thông tin", StackTrace.current);
      return;
    }

    final userName = ref.read(authNotifierProvider).value?.info?.username;
    if(userName!=model.oldUsername){
      state = AsyncError("Tên tài khoản không hợp lệ", StackTrace.current);
      return;
    }

    if (model.confirmPassword != model.newPassword) {
      state = AsyncError("Mật khẩu không khớp", StackTrace.current);
      return;
    }
    state = AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await _repo.changeInfoUser(model);
    });
  }
}
