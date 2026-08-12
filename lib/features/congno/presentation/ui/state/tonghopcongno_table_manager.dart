import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/congno/data/model/tonghop_congno_model.dart';
import 'package:trina_grid/trina_grid.dart';

class TongHopCongNoTableManager extends AppTableState<TongHopCongNoModel>{
  final TrinaGridStateManager _stateManager;

  TongHopCongNoTableManager(this._stateManager);

  @override
  void loadView(List<TongHopCongNoModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'MaKH': TrinaCell(value: e.maKH ?? ''),
      'TenKH': TrinaCell(value: e.tenKH ?? ''),
      'PhaiThu': TrinaCell(value: e.phaiThu),
      'PhaiTra': TrinaCell(value: e.phaiTra),
    })).toList());
  }

}