import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socaitk_model.dart';
import 'package:trina_grid/trina_grid.dart';

class SoCaiTKTableManager extends AppTableState<SoCaiTkModel>{
  final TrinaGridStateManager _stateManager;

  SoCaiTKTableManager(this._stateManager);

  @override
  void loadView(List<SoCaiTkModel> data) {
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
    })).toList());
  }
  
}