import 'package:erp_client_1/features/system/users/data/model/user_add_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_edit_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_update_model.dart';
import 'package:erp_client_1/features/system/users/data/model/user_view_model.dart';

abstract interface class IUserRepository {
  Future<List<UserViewModel>> getView();

  Future<void> add(UserAddModel user);

  Future<void> update(UserUpdateModel user, int id);

  Future<int> delete(int id);

  Future<UserEditModel> getEdit(int id);

  Future<void> updatePassword(String password, int id);
}
