import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/phat_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/utils/date_helper.dart';

class PhatTableManager extends AppTableState<PhatModel>{
  final TrinaGridStateManager _stateManager;

  PhatTableManager(this._stateManager);


  @override
  void loadView(List<PhatModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'Nam': TrinaCell(value: e.nam??''),
      'Id': TrinaCell(value: e.id),
      'Ngay': TrinaCell(value: DateHelper.dMy(e.ngay)??''),
      'NoiDung': TrinaCell(value: e.noiDung??''),
      'SoKiemTra': TrinaCell(value: e.soKiemTra),
      'SoDaNop': TrinaCell(value: e.soDaNop),
      'ConPhaiNop': TrinaCell(value: e.conPhaiNop),

    })).toList());
  }
  void showLoading(){
    _stateManager.setShowLoading(true);
  }

  void closeLoading(){
    _stateManager.setShowLoading(false);
  }

  PhatModel toModel(TrinaGridOnChangedEvent event) {
    Map<String, dynamic>  row = event.row.toJson();
    row.remove('stt');
    event.row.cells['ConPhaiNop']?.value = event.row.cells['SoKiemTra']?.value-event.row.cells['SoDaNop']?.value;
    _stateManager.notifyListeners();
    return PhatModel.fromJson(row);
  }
}