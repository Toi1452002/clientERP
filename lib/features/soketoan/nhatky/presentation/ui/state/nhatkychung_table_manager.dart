import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/nhatkychung_model.dart';
import 'package:trina_grid/trina_grid.dart';

class NhatKyChungTableManager extends AppTableState<NhatKyChungModel>{
  final TrinaGridStateManager _stateManager;

  NhatKyChungTableManager(this._stateManager);

  @override
  void loadView(List<NhatKyChungModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'Ngay': TrinaCell(value: e.ngay),
      'ChungTu': TrinaCell(value: e.chungTu??""),
      'NgayCT': TrinaCell(value: e.ngayCT),
      'DienGiai': TrinaCell(value: e.dienGiai ?? ''),
      'TKNo': TrinaCell(value: e.tkNo ?? ''),
      'TKCo': TrinaCell(value: e.tkCo ?? ''),
      'SoPS': TrinaCell(value: e.soPS),

    })).toList());
    _stateManager.setShowColumnFilter(true);
  }


}