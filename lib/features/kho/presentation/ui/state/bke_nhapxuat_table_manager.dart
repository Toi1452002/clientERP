import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/kho/data/model/bke_nhapxuat_model.dart';
import 'package:trina_grid/trina_grid.dart';

class BKeNhapXuatTableManager extends AppTableState<BKeNhapXuatModel>{
  final TrinaGridStateManager _stateManager;

  BKeNhapXuatTableManager(this._stateManager);

  @override
  void loadView(List<BKeNhapXuatModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'Ngay': TrinaCell(value: e.ngay),
      'Phieu': TrinaCell(value: e.phieu),
      'MaNX': TrinaCell(value: e.maNX),
      'MaKH': TrinaCell(value: e.maKH ?? ''),
      'MaHH': TrinaCell(value: e.maHH ?? ''),
      'TenHH': TrinaCell(value: e.tenHH ?? ''),
      'DVT': TrinaCell(value: e.dvt ?? ''),
      'SoLg': TrinaCell(value: e.soLg),
      'DonGia': TrinaCell(value: e.donGia),
      'ThanhTien': TrinaCell(value: e.thanhTien),
    })).toList());
    _stateManager.setShowColumnFilter(true);
  }

}