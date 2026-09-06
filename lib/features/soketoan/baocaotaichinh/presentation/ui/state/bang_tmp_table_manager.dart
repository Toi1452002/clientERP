import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_tmp_model.dart';
import 'package:trina_grid/trina_grid.dart';

class BangTmpTableManager extends AppTableState<BangTmpModel>{

  final TrinaGridStateManager _stateManager;

  BangTmpTableManager(this._stateManager);


  @override
  void loadView(List<BangTmpModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'ChiTieu': TrinaCell(value: e.chiTieu),
      'MaSo': TrinaCell(value: e.maSo),
      'ThuyetMinh': TrinaCell(value: e.thuyetMinh ?? ''),
      'SoNamNay': TrinaCell(value: e.soNamNay),
      'SoNamTruoc': TrinaCell(value: e.soNamTruoc),
      'PhanCap': TrinaCell(value: e.phanCap)
    })).toList());
  }

}