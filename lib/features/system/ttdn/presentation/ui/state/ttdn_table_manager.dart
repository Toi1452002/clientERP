import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/system/ttdn/data/model/ttdn_model.dart';
import 'package:trina_grid/trina_grid.dart';

class TTDNTableManager extends AppTableState<TTDNModel> {
  final TrinaGridStateManager _stateManager;

  TTDNTableManager(this._stateManager);

  @override
  void loadView(List<TTDNModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      data
          .map(
            (e) => TrinaRow(
              cells: {
                'stt': TrinaCell(),
                'Id': TrinaCell(value: e.id),
                'TieuDe': TrinaCell(value: e.tieuDe),
                'NoiDung': TrinaCell(value: e.noiDung),
              },
            ),
          )
          .toList(),
    );
  }
}
