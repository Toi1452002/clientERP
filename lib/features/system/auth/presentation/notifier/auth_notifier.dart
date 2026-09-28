import 'dart:async';

import 'package:erp_client_1/features/system/auth/data/model/auth_model.dart';
import 'package:erp_client_1/features/system/auth/data/repository/auth_repository.dart';
import 'package:erp_client_1/features/system/auth/data/repository/iauth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/data/local/storage/storage_name.dart';
import '../../../../../core/data/local/storage/storage_provider.dart';

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthModel?>(AuthNotifier.new, retry: (_, _) => null);

// final loginErrorState = StateProvider<String?>((ref) => null);

class AuthNotifier extends AsyncNotifier<AuthModel?> {
  IAuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  FutureOr<AuthModel?> build() async {
    return await checkLogin();
    // return null;
  }

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      state = AsyncError("Không đủ thông tin đăng nhập", StackTrace.empty);
      return;
    }
    state = AsyncLoading();
    state = await AsyncValue.guard(() => _repo.login(username, password));
    final auth = state.value;
    if (auth != null) {
      await ref.read(storageProvider).saveString(stToken, auth.accessToken);
      await ref.read(storageProvider).saveString(stRefreshToken, auth.refreshToken);
    }
  }

  Future<void> setValue(AuthModel? auth) async {
    if (auth == null) {
      logout(isRefresh: true);
      return;
    }
    await ref.read(storageProvider).saveString(stToken, auth.accessToken);
    await ref.read(storageProvider).saveString(stRefreshToken, auth.refreshToken);
  }

  Future<AuthModel?> checkLogin() async {
    // Kiem tra da login chua
    final token = await ref.read(storageProvider).getString(stToken);
    final refreshToken = await ref.read(storageProvider).getString(stRefreshToken);
    if (token == null) {
      await logout(isRefresh: true);
      return null;
    } else {
      try {
        final data = await _repo.getMe();
        return AuthModel(accessToken: token, refreshToken: refreshToken!, info: data);
      } catch (e, s) {
        state = AsyncError(e, s);
        return null;
      }
    }
  }

  Future<void> logout({bool isRefresh = false}) async {
    state = AsyncData(null);
    if (!isRefresh) await _repo.logout(); //gui request xoa token
    await ref.read(storageProvider).removeStore(stToken);
    await ref.read(storageProvider).removeStore(stRefreshToken);
  }
}
