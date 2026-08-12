import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hoadon_mua_model.dart';
import 'package:trina_grid/trina_grid.dart';

class BkeHoaDonMuaManager extends AppTableState<BKeHoaDonMuaModel>{
  final TrinaGridStateManager _stateManager;
  BkeHoaDonMuaManager(this._stateManager);

  @override
  void loadView(List<BKeHoaDonMuaModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'Phieu': TrinaCell(value: e.phieu),
      'KyHieu': TrinaCell(value: e.kyHieu??""),
      'SoCT': TrinaCell(value: e.soCT??""),
      'NgayCT': TrinaCell(value: e.ngayCT),
      'TenKH': TrinaCell(value: e.tenKH),
      'MST': TrinaCell(value: e.mst),
      'CongTien': TrinaCell(value: e.congTien),
      'TienThue': TrinaCell(value: e.tienThue),
      'DienGiai': TrinaCell(value: e.dienGiai)
    })).toList());
  }

}