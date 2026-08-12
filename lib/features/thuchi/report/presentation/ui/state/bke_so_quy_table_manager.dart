import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/thuchi/report/data/model/bke_so_quy_model.dart';
import 'package:trina_grid/trina_grid.dart';

class BKeSoQuyTableManager extends AppTableState<BKeSoQuyModel>{
  final TrinaGridStateManager _stateManager;
  BKeSoQuyTableManager(this._stateManager);

  @override
  void loadView(List<BKeSoQuyModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'null': TrinaCell(value: ''),
      'Ngay': TrinaCell(value: e.ngay),
      'Phieu': TrinaCell(value: e.phieu),
      'DienGiai': TrinaCell(value: e.dienGiai),
      'Kieu': TrinaCell(value: e.kieu),
      'PTTT': TrinaCell(value: e.pttt),
      'ChungTu': TrinaCell(value: e.chungTu),
      'TKDU': TrinaCell(value: e.tkDU),
      'Thu': TrinaCell(value: e.thu),
      'Chi': TrinaCell(value: e.chi),
    })).toList());
  }
  
}