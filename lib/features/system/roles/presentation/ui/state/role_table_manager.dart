import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/system/roles/data/model/role_model.dart';
import 'package:trina_grid/trina_grid.dart';

class RoleTableManager extends AppTableState<RoleModel>{
  final TrinaGridStateManager _stateManager;

  RoleTableManager(this._stateManager);

  @override
  void loadView(List<RoleModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'delete': TrinaCell(value: e.id),
      'RoleName': TrinaCell(value: e.roleName),
    })).toList());
  }
}