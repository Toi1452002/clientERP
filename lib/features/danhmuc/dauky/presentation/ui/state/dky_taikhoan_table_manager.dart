import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_taikhoan_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

class DKyTaiKhoanTableManager extends AppTableState<DKyTaiKhoanViewModel>{
  final TrinaGridStateManager _stateManager;

  DKyTaiKhoanTableManager(this._stateManager);
  @override
  void loadView(List<DKyTaiKhoanViewModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'MaTK': TrinaCell(value: e.maTK),
      'TenTK': TrinaCell(value: e.tenTK),
      'DKCo': TrinaCell(value: e.dkCo?? 0),
      'DKNo': TrinaCell(value: e.dkNo?? 0),
      'TinhChat': TrinaCell(value: e.tinhChat??""),
    })).toList());
  }

  void showLoading()=>_stateManager.setShowLoading(true);
  void closeLoading()=>_stateManager.setShowLoading(false);

}