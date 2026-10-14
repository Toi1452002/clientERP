import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/congno/data/model/somuahang_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../data/model/sobanhang_model.dart';

class SoBanHangTableManager extends AppTableState<SoBanHangModel>{
  final TrinaGridStateManager _stateManager;

  SoBanHangTableManager(this._stateManager);



  @override
  void loadView(List<SoBanHangModel> data) {
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
      'TienBan': TrinaCell(value: e.tienBan),
      'TienTra': TrinaCell(value: e.tienTra),
    },)).toList());
    _stateManager.setShowColumnFilter(true);
  }

}