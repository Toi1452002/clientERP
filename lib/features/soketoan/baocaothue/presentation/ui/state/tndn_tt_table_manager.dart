import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_tt_model.dart';
import 'package:trina_grid/trina_grid.dart';

class TNDNttTableManager extends AppTableState<TNDNttModel>{

  final TrinaGridStateManager _stateManager;

  TNDNttTableManager(this._stateManager);

  @override
  void loadView(List<TNDNttModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'PhanCap': TrinaCell(value: e.phanCap),
      'ChiTieu': TrinaCell(value: e.chiTieu),
      'SoNamNay': TrinaCell(value: e.soNamNay),

    })).toList());
  }

}