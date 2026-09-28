import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/widgets/app_table/app_table_state.dart';
import '../../../data/model/hanghoaview_model.dart';

class HangHoaTableManager extends AppTableState<HangHoaViewModel>{
  final TrinaGridStateManager _stateManager;
  HangHoaTableManager(this._stateManager);

  @override
  void loadView(List<HangHoaViewModel> data) {
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(
        cells: {
          "stt": TrinaCell(value: ''),
          "delete": TrinaCell(value: e.id),
          "MaHH": TrinaCell(value: e.maHH),
          "TenHH": TrinaCell(value: e.tenHH),
          "DVT": TrinaCell(value: e.dvt),
          "GiaMua": TrinaCell(value: e.giaMua),
          "GiaBan": TrinaCell(value: e.giaBan),
          "LoaiHang": TrinaCell(value: e.loaiHang),
          "NhomHang": TrinaCell(value: e.nhomHang),
          "MaNC": TrinaCell(value: e.maNC),
        }
    )).toList());
  }


  void showFilter()=> _stateManager.setShowColumnFilter(true);

  void showLoading ()=> _stateManager.setShowLoading(true);
  void closeLoading ()=> _stateManager.setShowLoading(false);
  void clearFilter()=>_stateManager.clearAllColumnFilters();
}