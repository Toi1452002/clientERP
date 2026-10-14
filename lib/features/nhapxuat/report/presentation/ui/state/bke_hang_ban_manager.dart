import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hangban_model.dart';
import 'package:trina_grid/trina_grid.dart';

class BkeHangBanManager extends AppTableState<BkeHangBanModel>{
  final TrinaGridStateManager _stateManager;
  BkeHangBanManager(this._stateManager);

  @override
  void loadView(List<BkeHangBanModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      "stt": TrinaCell(value: ''),
      'MaHH': TrinaCell(value: e.maHH),
      'TenHH': TrinaCell(value: e.tenHH),
      'DVT': TrinaCell(value: e.dvt),
      'SoLg': TrinaCell(value: e.soLg),
      'ThanhTien': TrinaCell(value: e.thanhTien),
      'ThueSuat': TrinaCell(value: e.thueSuat),
      'TienThue': TrinaCell(value: e.tienThue),
      'CongTien': TrinaCell(value: e.congTien),
    })).toList());
    _stateManager.setShowColumnFilter(true);
  }

}