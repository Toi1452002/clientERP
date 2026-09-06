import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_model.dart';
import 'package:trina_grid/trina_grid.dart';

class TNDNTableManager extends AppTableState<TNDNModel>{
  final TrinaGridStateManager _stateManager;

  TNDNTableManager(this._stateManager);


  @override
  void loadView(List<TNDNModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'PhanCap': TrinaCell(value: e.phanCap),
      'ChiTieu': TrinaCell(value: e.chiTieu),
      'SoNamNay':TrinaCell(value: e.soNamNay),
      'MaSo': TrinaCell(value: e.maSo)

    })).toList());
  }

}