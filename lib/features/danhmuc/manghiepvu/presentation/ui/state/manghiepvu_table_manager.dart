import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../data/model/manghiepvu_request_model.dart';

class MaNghiepVuTableManager extends AppTableState<MaNghiepVuModel> {
  final TrinaGridStateManager _stateManager;

  MaNghiepVuTableManager(this._stateManager);

  @override
  void loadView(List<MaNghiepVuModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      data
          .map(
            (e) => TrinaRow(
              cells: {
                'stt': TrinaCell(),
                'delete': TrinaCell(value: e.id),
                'MaNV': TrinaCell(value: e.maNV),
                'MoTa': TrinaCell(value: e.moTa),
              },
            ),
          )
          .toList(),
    );
  }

  void showLoading() => _stateManager.setShowLoading(true);

  void closeLoading() => _stateManager.setShowLoading(false);

  MaNghiepVuRequestModel toMap(TrinaRow row) {
    return MaNghiepVuRequestModel(maNV: row.cells['MaNV']?.value, moTa: row.cells['MoTa']?.value);
  }
}
