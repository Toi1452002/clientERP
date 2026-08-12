import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_hanghoa_request_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_hanghoa_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/utils/date_helper.dart';

class DKyHangHoaTableManager extends AppTableState<DKyHangHoaViewModel> {
  final TrinaGridStateManager _stateManager;

  DKyHangHoaTableManager(this._stateManager);

  @override
  void loadView(List<DKyHangHoaViewModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      data
          .map(
            (e) => TrinaRow(
              cells: {
                'stt': TrinaCell(),
                'HangHoaId': TrinaCell(value: e.id),
                'Ngay': TrinaCell(value: DateHelper.dMy(e.ngay)),
                'MaHH': TrinaCell(value: e.maHH),
                'TenHH': TrinaCell(value: e.tenHH),
                'SoTon': TrinaCell(value: e.soTon),
                'GiaVon': TrinaCell(value: e.giaVon),
              },
            ),
          )
          .toList(),
    );
  }

  List<DKyHangHoaRequestModel> toList() {
    final x = _stateManager.rows.where((e) => e.cells['GiaVon']?.value != 0).toList();
    return x
        .map(
          (e) => DKyHangHoaRequestModel(
            ngay: DateHelper.stringToDate(e.cells['Ngay']?.value)!,
            hangHoaId: e.cells['HangHoaId']?.value,
            giaVon: e.cells['GiaVon']?.value,
            soTon: e.cells['SoTon']?.value,
          ),
        )
        .toList();
  }
}
