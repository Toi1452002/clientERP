import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/kho/data/model/nhapxuatton_model.dart';
import 'package:trina_grid/trina_grid.dart';

class NhapXuatTonTableManager extends AppTableState<NhapXuatTonModel>{
  final TrinaGridStateManager _stateManager;

  NhapXuatTonTableManager(this._stateManager);


  @override
  void loadView(List<NhapXuatTonModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'TenHH': TrinaCell(value: e.tenHH),
      'DVT': TrinaCell(value: e.dvt),
      'SD': TrinaCell(value: e.sd ),
      'TD': TrinaCell(value: e.td ),
      'SN': TrinaCell(value: e.sn),
      'TN': TrinaCell(value: e.tn),
      'SX': TrinaCell(value: e.sx),
      'GX': TrinaCell(value: e.gx),
      'TX': TrinaCell(value: e.tx),
      'SC': TrinaCell(value: e.sc),
      'TC': TrinaCell(value: e.tc),
    })).toList());
  }

}