import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/widgets/app_table/app_table_state.dart';
import '../../../data/model/nhomhang_model.dart';

class NhomHangTableManager extends AppTableState<NhomHangModel>{
  late final TrinaGridStateManager _stateManager;
  NhomHangTableManager(this._stateManager);


  @override
  void loadView(List<NhomHangModel> data) {
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'delete': TrinaCell(value: e.id),
      'NhomHang': TrinaCell(value: e.nhomHang)
    })).toList());
  }

  void showLoading()=> _stateManager.setShowLoading(true);
  void closeLoading()=> _stateManager.setShowLoading(false);
}