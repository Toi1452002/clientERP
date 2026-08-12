import 'package:erp_client_1/features/system/roles/data/model/role_model.dart';

abstract interface class IRoleRepository {
  Future<List<RoleModel>> getView();

  Future<int> add(String roleName);

  Future<int> update(String roleName, int id);

  Future<int> delete(int id);
}
