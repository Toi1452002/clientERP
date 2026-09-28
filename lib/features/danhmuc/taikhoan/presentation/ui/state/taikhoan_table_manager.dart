import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

class TaiKhoanTablemanager extends AppTableState<TaiKhoanViewModel>{
  final TrinaGridStateManager _stateManager;
  TaiKhoanTablemanager(this._stateManager);

  @override
  void loadView(List<TaiKhoanViewModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'delete': TrinaCell(value: e.id),
      'MaTK': TrinaCell(value:  e.maTK),
      'TenTK': TrinaCell(value:  e.tenTK),
      'TinhChat': TrinaCell(value: e.tinhChat??''),
      'GhiChu': TrinaCell(value: e.ghiChu),
      'MaXL': TrinaCell(value:  e.maXL)
    })).toList());
  }

  void showLoading()=>_stateManager.setShowLoading(true);
  void closeLoading()=>_stateManager.setShowLoading(false);

}