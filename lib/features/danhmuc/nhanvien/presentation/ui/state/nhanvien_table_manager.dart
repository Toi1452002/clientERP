import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';



class NhanVienTableManager extends AppTableState<NhanVienViewModel>{
  final TrinaGridStateManager _state;

  NhanVienTableManager(this._state);

  @override
  void loadView(List<NhanVienViewModel> data) {
    // TODO: implement loadView
    _state.removeAllRows();
    _state.appendRows(data.map((e){
      return TrinaRow(cells: {
        'stt': TrinaCell(),
        'delete': TrinaCell(value: e.id),
        'MaNV': TrinaCell(value: e.maNV),
        'TenNV': TrinaCell(value: e.tenNV),
        'GioiTinh': TrinaCell(value: e.gioiTinh? 'Nữ' : 'Nam'),
        'NgaySinh':TrinaCell(value: e.ngaySinh),
        'DiaChi':TrinaCell(value: e.diaChi),
        'TrinhDo':TrinaCell(value: e.trinhDo),
        'ChuyenMon':TrinaCell(value: e.chuyenMon),
      });
    }).toList());
  }

}