import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/congno/data/model/somuahang_model.dart';
import 'package:trina_grid/trina_grid.dart';

class SoMuaHangTableManager extends AppTableState<SoMuaHangModel>{
  final TrinaGridStateManager _stateManager;

  SoMuaHangTableManager(this._stateManager);



  @override
  void loadView(List<SoMuaHangModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'Ngay': TrinaCell(value: e.ngay),
      'Phieu': TrinaCell(value: e.phieu),
      'DienGiai': TrinaCell(value: e.dienGiai),
      'DVT': TrinaCell(value: e.dvt),
      'SoLg': TrinaCell(value: e.soLg),
      'DonGia': TrinaCell(value: e.donGia),
      'TienMua': TrinaCell(value: e.tienMua),
      'TienTra': TrinaCell(value: e.tienTra),
    },)).toList());
    _stateManager.setShowColumnFilter(true);
  }

}