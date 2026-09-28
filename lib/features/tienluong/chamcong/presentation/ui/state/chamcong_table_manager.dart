import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/chamcong_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

class ChamCongTableManager extends AppTableState<ChamCongViewModel>{
  final TrinaGridStateManager _stateManager;

  ChamCongTableManager(this._stateManager);

  void changedThang(int thang, String nam){
    for (int i = 1; i <= 31; i++) {
      _stateManager.columns[4 + i].title = _ckNgay(i, thang, nam) ? '$i' : '';
    }
    _stateManager.notifyListeners();
  }

  bool _ckNgay(int ngay, int thang, String nam) {
    final date = DateTime(int.parse(nam), thang + 1, 0).day;
    return date >= ngay;
  }

  @override
  void loadView(List<ChamCongViewModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'delete':  TrinaCell(value:  e.id),
      'MaNV': TrinaCell(value:  e.maNV),
      'TenNV': TrinaCell(value: e.tenNV??''),
      'TongCong': TrinaCell(value: e.tongCong),
      ...e.ngay.map((a,b)=>MapEntry(a.toString(),TrinaCell(value: b.kyHieu))),
    })).toList());

  }

  void showLoading()=>_stateManager.setShowLoading(true);
  void closeLoading()=>_stateManager.setShowLoading(false);
}