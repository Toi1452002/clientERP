import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_cdps_model.dart';
import 'package:trina_grid/trina_grid.dart';

class BangCDPSTableManager extends AppTableState<BangCDPSModel>{
  final TrinaGridStateManager _stateManager;

  BangCDPSTableManager(this._stateManager);

  @override
  void loadView(List<BangCDPSModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'MaTK': TrinaCell(value: e.maTK),
      'TenTK': TrinaCell(value: e.tenTK),
      'DKNo': TrinaCell(value: e.dkNo),
      'DKCo': TrinaCell(value: e.dkCo),
      'PSNo': TrinaCell(value: e.psNo),
      'PSCo': TrinaCell(value: e.psCo),
      'CKNo': TrinaCell(value: e.ckNo),
      'CKCo': TrinaCell(value: e.ckCo),
      'Cap': TrinaCell(value: e.cap),
    })).toList());
  }

}