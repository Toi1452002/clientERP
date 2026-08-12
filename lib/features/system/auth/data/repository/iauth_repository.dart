import 'package:erp_client_1/features/system/auth/data/model/auth_info_model.dart';
import 'package:erp_client_1/features/system/auth/data/model/auth_menu_model.dart';
import 'package:erp_client_1/features/system/auth/data/model/auth_model.dart';

abstract interface class IAuthRepository {
  Future<AuthModel> login(String username, String password);

  Future<void> logout();

  Future<AuthInfoModel> getMe();

  Future<AuthModel> refreshToken(String refreshToken);

  Future<List<AuthMenuModel>> getMenu(int roleId);
}
