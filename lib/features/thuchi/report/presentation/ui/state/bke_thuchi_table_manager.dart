import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/thuchi/report/data/model/bke_thu_chi_model.dart';
import 'package:trina_grid/trina_grid.dart';

class BKeThuChiTableManager extends AppTableState<BKeThuChiModel>{
  final TrinaGridStateManager _stateManager;

  BKeThuChiTableManager(this._stateManager);

  @override
  void loadView(List<BKeThuChiModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'Ngay': TrinaCell(value: e.ngay),
      'Phieu': TrinaCell(value: e.phieu),
      'Kieu': TrinaCell(value: e.kieu),
      'MaKH': TrinaCell(value: e.maKH??""),
      'TenKH': TrinaCell(value: e.tenKH),
      'PTTT': TrinaCell(value: e.pttt),
      'NoiDung': TrinaCell(value: e.noiDung),
      'SoTien': TrinaCell(value: e.soTien),
      'TKNo': TrinaCell(value: e.tkNo),
      'TKCo': TrinaCell(value: e.tkCo),
    })).toList());
    _stateManager.setShowColumnFilter(true);
  }

}