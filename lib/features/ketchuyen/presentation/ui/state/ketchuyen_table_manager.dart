import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/ketchuyen/data/model/ketchuyen_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../core/utils/date_helper.dart';

class KetChuyenTableManager extends AppTableState<KetChuyenViewModel> {
  final TrinaGridStateManager _stateManager;

  KetChuyenTableManager(this._stateManager);

  @override
  void loadView(List<KetChuyenViewModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      data
          .map(
            (e) => TrinaRow(
              cells: {
                'stt': TrinaCell(),
                'delete': TrinaCell(value: e.id),
                'ButToan': TrinaCell(value: e.butToan),
                'Ngay': TrinaCell(value: DateHelper.dMy(e.ngay)),
                'SoCT': TrinaCell(value: e.soCT ?? ""),
                'NgayCT': TrinaCell(value: DateHelper.dMy(e.ngayCT)),
                'DienGiai': TrinaCell(value: e.dienGiai ?? ""),
                'TKNo': TrinaCell(value: e.tkNo),
                'TKCo': TrinaCell(value: e.tkCo),
                'SoPS': TrinaCell(value: e.soPS),
              },
            ),
          )
          .toList(),
    );
  }

  void add(int id) {
    _stateManager.appendRows([
      TrinaRow(
        cells: {
          'stt': TrinaCell(),
          'delete': TrinaCell(value: id),
          'ButToan': TrinaCell(value: null),
          'Ngay': TrinaCell(value: DateHelper.dMy(DateTime.now())),
          'SoCT': TrinaCell(value: ""),
          'NgayCT': TrinaCell(value: DateHelper.dMy(DateTime.now())),
          'DienGiai': TrinaCell(value: ""),
          'TKNo': TrinaCell(value: null),
          'TKCo': TrinaCell(value: null),
          'SoPS': TrinaCell(value: null),
        },
      ),
    ]);
  }

  KetChuyenViewModel toModel(TrinaRow row) {
    return KetChuyenViewModel(
      id: row.cells['delete']?.value,
      butToan: row.cells['ButToan']?.value,
      ngay: DateHelper.stringToDate(row.cells['Ngay']?.value),
      ngayCT: DateHelper.stringToDate(row.cells['NgayCT']?.value),
      soCT: row.cells['SoCT']?.value,
      tkNo: row.cells['TKNo']?.value,
      tkCo: row.cells['TKCo']?.value,
      soPS: row.cells['SoPS']?.value,
      dienGiai: row.cells['DienGiai']?.value
    );
  }
}
