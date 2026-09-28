import 'package:erp_client_1/features/danhmuc/dvt/data/model/dvt_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/widgets/app_table/app_table_state.dart';

class DvtTableManager extends AppTableState<DvtModel>{
  late final TrinaGridStateManager _stateManager;
  DvtTableManager(this._stateManager);


  @override
  void loadView(List<DvtModel> data) {
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'delete': TrinaCell(value: e.id),
      'DVT': TrinaCell(value: e.dvt)
    })).toList());
  }


  void closeLoading()=>_stateManager.setShowLoading(false);
  void showLoading()=>_stateManager.setShowLoading(true);

}