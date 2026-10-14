import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socttk_model.dart';
import 'package:trina_grid/trina_grid.dart';

class SoCTTKTableManager extends AppTableState<SoCTTKModel>{
  final TrinaGridStateManager _stateManager;

  SoCTTKTableManager(this._stateManager);

  @override
  void loadView(List<SoCTTKModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'Ngay': TrinaCell(value: e.ngay),
      'ChungTu': TrinaCell(value: e.chungTu),
      'NgayCT': TrinaCell(value: e.ngayCT),
      'DienGiai': TrinaCell(value: e.dienGiai ?? ''),
      'TKDU': TrinaCell(value: e.tkdu),
      'PSNo': TrinaCell(value: e.psNo),
      'PSCo': TrinaCell(value: e.psCo),
      'SDNo': TrinaCell(value: e.soDuNo),
      'SDCo': TrinaCell(value: e.soDuCo),
    })).toList());
    _stateManager.setShowColumnFilter(true);
  }

}