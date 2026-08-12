import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:trina_grid/trina_grid.dart';

// final pcgtTableProvider = StateProvider<PCGTTableManager>((ref) {
//   return PCGTTableManager();
// });
class PCGTTableManager extends AppTableState<PCGTViewModel> {
  late final TrinaGridStateManager _state;

  PCGTTableManager(this._state);

  @override
  void loadView(List<PCGTViewModel> data) {
    // TODO: implement loadView
    _state.removeAllRows();
    _state.appendRows(
      data
          .map(
            (e) => TrinaRow(
              cells: {
                'stt': TrinaCell(value: e.maPC),
                'MoTa': TrinaCell(value: e.moTa),
                'SoTieuChuan': TrinaCell(value: e.soTieuChuan),
              },
            ),
          )
          .toList(),
    );
  }

  List<PCGTRequestModel> toRequest() {
    List<PCGTRequestModel> x = _state.rows.map((e) {
      return PCGTRequestModel(maPC: e.cells['stt']?.value, soTieuChuan: e.cells['SoTieuChuan']?.value);
    }).toList();
    return x;
  }
}
