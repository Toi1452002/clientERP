import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/widgets/app_table/app_table_state.dart';
import '../../../data/model/khach_view_model.dart';

class KhachTableManager extends AppTableState<KhachViewModel> {
  late final TrinaGridStateManager _stateManager;

  KhachTableManager(this._stateManager);

  @override
  void loadView(List<KhachViewModel> data) {
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      data
          .map(
            (e) => TrinaRow(
          cells: {
            'stt': TrinaCell(value: e.id),
            'delete': TrinaCell(value: e.id),
            'MaKH': TrinaCell(value: e.maKH),
            'TenKH': TrinaCell(value: e.tenKH),
            'DiaChi': TrinaCell(value: e.diaChi),
            'MST': TrinaCell(value: e.mst),
            'DiDong': TrinaCell(value: e.diDong),
            'LoaiKH': TrinaCell(value: e.loaiKH),
          },
        ),
      )
          .toList(),
    );
  }
  void showFilter()=> _stateManager.setShowColumnFilter(true);

  void showLoading ()=> _stateManager.setShowLoading(true);
  void closeLoading ()=> _stateManager.setShowLoading(false);
  void clearFilter ()=> _stateManager.clearAllColumnFilters();
}
