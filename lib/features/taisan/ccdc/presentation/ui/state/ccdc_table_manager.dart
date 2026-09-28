import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/taisan/ccdc/data/model/ccdc_update_model.dart';
import 'package:erp_client_1/features/taisan/ccdc/data/model/ccdc_view_model.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/utils/date_helper.dart';
import '../../../../tscd/data/model/tscd_view_model.dart';

class CCDCTableManager extends AppTableState<CCDCViewModel>{
  final TrinaGridStateManager _stateManager;

  CCDCTableManager(this._stateManager);

  @override
  void loadView(List<CCDCViewModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: ''),
      'delete': TrinaCell(value: e.id),
      'HangHoaId': TrinaCell(value: e.hangHoaId),
      'TenHH': TrinaCell(value: e.tenHH),
      'BoPhanSD': TrinaCell(value: e.boPhanSD ?? ''),
      'SoLuong': TrinaCell(value: e.soLuong),
      'GiaTri': TrinaCell(value: e.giaTri),
      'NgayMua': TrinaCell(value: DateHelper.dMy(e.ngayMua) ?? ''),
      'NgaySD': TrinaCell(value: DateHelper.dMy(e.ngaySD) ?? ""),
      'SoThangPB': TrinaCell(value: e.soThangPB),
      'GiaTriKhauHao': TrinaCell(value: e.giaTriKhauHao),
      'LuyKe': TrinaCell(value: e.luyKe ),
      'GiaTriConLai': TrinaCell(value: e.giaTriConLai),
      'TKChiPhi': TrinaCell(value: e.tkChiPhi),
      'TKHaoMon': TrinaCell(value: e.tkHaoMon),
    })).toList());
  }
  void showLoading()=>_stateManager.setShowLoading(true);
  void closeLoading()=>_stateManager.setShowLoading(false);

  void updateRow(int id, CCDCViewModel model){
    final rowIndex = _stateManager.rows.indexWhere(
          (row) => row.cells['delete']?.value == id,
    );
    if(rowIndex!=-1){

      final row = _stateManager.rows[rowIndex];
      row.cells['TenHH']?.value = model.tenHH;
      row.cells['GiaTri']?.value = model.giaTri;
      _stateManager.notifyListeners();
    }
  }

  void addRow(CCDCViewModel e){
    _stateManager.appendRows([
      TrinaRow(
        cells: {
          'stt': TrinaCell(value: ''),
          'delete': TrinaCell(value: e.id),
          'HangHoaId': TrinaCell(value: e.hangHoaId),
          'TenHH': TrinaCell(value: e.tenHH),
          'BoPhanSD': TrinaCell(value: e.boPhanSD ?? ''),
          'SoLuong': TrinaCell(value: e.soLuong),
          'GiaTri': TrinaCell(value: e.giaTri),
          'NgayMua': TrinaCell(value: DateHelper.dMy(e.ngayMua) ?? ''),
          'NgaySD': TrinaCell(value: DateHelper.dMy(e.ngaySD) ?? ""),
          'SoThangPB': TrinaCell(value: e.soThangPB),
          'GiaTriKhauHao': TrinaCell(value: e.giaTriKhauHao),
          'LuyKe': TrinaCell(value: e.luyKe ),
          'GiaTriConLai': TrinaCell(value: e.giaTriConLai),
          'TKChiPhi': TrinaCell(value: e.tkChiPhi),
          'TKHaoMon': TrinaCell(value: e.tkHaoMon),
        },
      )
    ]);
  }

  CCDCUpdateModel toModel(TrinaRow row) {
    return CCDCUpdateModel(
        hangHoaId: row.cells['HangHoaId']?.value,
        boPhanSD: row.cells['BoPhanSD']?.value,
        ngayMua: DateHelper.stringToDate(row.cells['NgayMua']?.value),
        ngaySD: DateHelper.stringToDate(row.cells['NgaySD']?.value),
        giaTri: row.cells['GiaTri']?.value,
        soThangPB: row.cells['SoThangPB']?.value,
        tkChiPhi: row.cells['TKChiPhi']?.value,
        tkHaoMon: row.cells['TKHaoMon']?.value,
      soLuong: row.cells['SoLuong']?.value
    );
  }
}