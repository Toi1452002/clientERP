import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/system/menu_permission/data/model/menu_permission_model.dart';
import 'package:trina_grid/trina_grid.dart';

class MenuPermissionTableManager extends AppTableState<MenuPermissionModel> {
  final TrinaGridStateManager _stateManager;

  MenuPermissionTableManager(this._stateManager);

  @override
  void loadView(List<MenuPermissionModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      data
          .map(
            (e) => TrinaRow(
              cells: {
                'Level': TrinaCell(value: e.level),
                'stt': TrinaCell(value: e.id),
                'TreeName': TrinaCell(value: e.treeName),
                'Status': TrinaCell(value: e.choPhep),
              },
            ),
          )
          .toList(),
    );
  }

  List<int> listKChoPhep() {
    final x = _stateManager.rows.where((e) => e.cells['Status']?.value == false).toList();
    final lstJson = x.map((e) => e.toJson()).toList();
    return lstJson.map((e) => int.parse(e['stt'].toString())).toList();
  }
}
