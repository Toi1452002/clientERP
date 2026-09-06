import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../data/model/tncn_model.dart';
class TNCNTableManager extends AppTableState<TNCNModel>{
  final TrinaGridStateManager _stateManager;

  TNCNTableManager(this._stateManager);


  @override
  void loadView(List<TNCNModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'PhanCap': TrinaCell(value: e.phanCap),
      'STT': TrinaCell(value: e.stt),
      'ChiTieu': TrinaCell(value: e.chiTieu),
      'MaSo': TrinaCell(value: e.maSo),
      'DVT': TrinaCell(value: e.dvt),
      'SoNamNay': TrinaCell(value: e.soNamNay),
    })).toList());
  }

}