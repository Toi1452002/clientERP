import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_update_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/widgets/app_table/app_table_state.dart';

class BangLuongTableManager extends AppTableState<BangLuongViewModel> {
  final TrinaGridStateManager _stateManager;

  BangLuongTableManager(this._stateManager);

  @override
  void loadView(List<BangLuongViewModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(
      data
          .map(
            (e) => TrinaRow(
              cells: {
                'stt': TrinaCell(value: ''),
                'delete': TrinaCell(value: e.id),
                'MaNV': TrinaCell(value: e.maNV),
                'TenNV': TrinaCell(value: e.tenNV),
                'ChucVu': TrinaCell(value: e.chucVu),
                'LuongCoBan': TrinaCell(value: e.luongCoBan),
                'PC1': TrinaCell(value: e.pc1),
                'PC2': TrinaCell(value: e.pc2),
                'LuongBHXH': TrinaCell(value: e.luongBHXH),
                'BH': TrinaCell(value: e.bh),
                'NgayCong': TrinaCell(value: e.ngayCong),
                'LuongThoiGian': TrinaCell(value: e.luongThoiGian),
                'TNchiuThue': TrinaCell(value: e.tNchiuthue),
                'TongThuNhap': TrinaCell(value: e.tongThuNhap),
                'GT': TrinaCell(value: e.gt),
                'TNtinhThue': TrinaCell(value: e.tNtinhthue),
                'ThueCN': TrinaCell(value: e.thueCN),
                'ThucLanh': TrinaCell(value: e.thucLanh),
                'TamUng': TrinaCell(value: e.tamUng),
                'ConLai': TrinaCell(value: e.conLai),
              },
            ),
          )
          .toList(),
    );
  }

  void showLoading() => _stateManager.setShowLoading(true);

  void closeLoading() => _stateManager.setShowLoading(false);

  BangLuongUpdateModel toModel(TrinaRow row) {
    return BangLuongUpdateModel(
      chucVu: row.cells['ChucVu']?.value,
      luongCoBan: row.cells['LuongCoBan']?.value,
      maNV: row.cells['MaNV']?.value,
      ngayCong: row.cells['NgayCong']?.value,
      tamUng: row.cells['TamUng']?.value,
    );
  }

  void updateRow(int id, BangLuongViewModel model) {
    final rowIndex = _stateManager.rows.indexWhere((row) => row.cells['delete']?.value == id);
    if (rowIndex != -1) {
      final row = _stateManager.rows[rowIndex];
      row.cells['TenNV']?.value = model.tenNV;
      row.cells['ChucVu']?.value = model.chucVu;
      row.cells['LuongCoBan']?.value = model.luongCoBan;
      row.cells['PC1']?.value = model.pc1;
      row.cells['PC2']?.value = model.pc2;
      row.cells['LuongBHXH']?.value = model.luongBHXH;
      row.cells['BH']?.value = model.bh;
      row.cells['NgayCong']?.value = model.ngayCong;
      row.cells['LuongThoiGian']?.value = model.luongThoiGian;
      row.cells['TongThuNhap']?.value = model.tongThuNhap;
      row.cells['GT']?.value = model.gt;
      row.cells['TNchiuThue']?.value = model.tNchiuthue;
      row.cells['TNtinhThue']?.value = model.tNtinhthue;
      row.cells['ThueCN']?.value = model.thueCN;
      row.cells['ThucLanh']?.value = model.thucLanh;
      row.cells['TamUng']?.value = model.tamUng;
      row.cells['ConLai']?.value = model.conLai;
      _stateManager.notifyListeners();
    }
  }
}
