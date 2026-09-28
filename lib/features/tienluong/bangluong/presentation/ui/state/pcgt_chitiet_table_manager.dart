import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

class PCGTChiTietTablemanager extends AppTableState<PCGTViewCTModel> {
  final TrinaGridStateManager _stateManager;

  PCGTChiTietTablemanager(this._stateManager);

  @override
  void loadView(List<PCGTViewCTModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e) => TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'MoTa': TrinaCell(value: e.moTa),
      'SoTieuChuan': TrinaCell(value: e.soTieuChuan),
      'SoThucTe': TrinaCell(value: e.soThucTe),
    })).toList());
  }
}
