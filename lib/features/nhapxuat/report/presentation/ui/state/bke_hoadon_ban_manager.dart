import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hoadon_mua_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../data/model/bke_hoadon_ban_model.dart';

class BkeHoaDonBanManager extends AppTableState<BKeHoaDonBanModel>{
  final TrinaGridStateManager _stateManager;
  BkeHoaDonBanManager(this._stateManager);

  @override
  void loadView(List<BKeHoaDonBanModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'Phieu': TrinaCell(value: e.phieu),
      'KyHieu': TrinaCell(value: e.kyHieu??""),
      'SoHD': TrinaCell(value: e.soHD??""),
      'NgayCT': TrinaCell(value: e.ngayCT),
      'TenKH': TrinaCell(value: e.tenKH),
      'MST': TrinaCell(value: e.mst),
      'CongTien': TrinaCell(value: e.congTien),
      'TienThue': TrinaCell(value: e.tienThue),
      'DienGiai': TrinaCell(value: e.dienGiai)
    })).toList());
    _stateManager.setShowColumnFilter(true);
  }

}