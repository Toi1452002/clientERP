import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_khachhang_request_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_khachhang_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

class DKyKhachHangTableManager extends AppTableState<DKyKhachHangViewModel> {
  final TrinaGridStateManager _stateManager;

  DKyKhachHangTableManager(this._stateManager);

  @override
  void loadView(List<DKyKhachHangViewModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      data
          .map(
            (e) => TrinaRow(
              cells: {
                'stt': TrinaCell(),
                'Ngay': TrinaCell(value: DateHelper.dMy(e.ngay)),
                'MaKH': TrinaCell(value: e.maKH),
                'TenKH': TrinaCell(value: e.tenKH),
                'SoDuNo': TrinaCell(value: e.soDuNo),
              },
            ),
          )
          .toList(),
    );
  }


  void showLoading() => _stateManager.setShowLoading(true);

  void closeLoading() => _stateManager.setShowLoading(false);


  List<DKyKhachHangRequestModel> toList() {
    final x = _stateManager.rows.where((e) => e.cells['SoDuNo']?.value != 0).toList();
    return x
        .map(
          (e) => DKyKhachHangRequestModel(
            ngay: DateHelper.stringToDate(e.cells['Ngay']?.value)!,
            maKH: e.cells['MaKH']?.value,
            soDuNo: e.cells['SoDuNo']?.value,
          ),
        )
        .toList();
  }
}
