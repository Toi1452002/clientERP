import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../data/model/phieuxuat_ct_model.dart';

class PhieuXuatCTTableManager extends AppTableState<PhieuXuatCTModel>{
  late final TrinaGridStateManager _stateManager;
  PhieuXuatCTTableManager(this._stateManager);

  @override
  void loadView(List<PhieuXuatCTModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'delete': TrinaCell(),
      'MaHH': TrinaCell(value: e.hangHoaId),
      'TenHH': TrinaCell(value: e.tenHH),
      'DVT': TrinaCell(value: e.dvt),
      'SoLg': TrinaCell(value: e.soLg),
      'DonGia': TrinaCell(value: e.donGia),
      'ThanhTien': TrinaCell(value: e.thanhTien),
      'TKKho':TrinaCell(value: e.tkKho),
      'TKgv':TrinaCell(value: e.tkgv),
    })).toList());
  }

  void addRow(){
    _stateManager.appendRows([
      TrinaRow(
        cells: {
          'stt': TrinaCell(value: ''),
          'delete': TrinaCell(value: ''),
          'MaHH': TrinaCell(value: null),
          'TenHH': TrinaCell(value: ''),
          'DVT': TrinaCell(value: null),
          'SoLg': TrinaCell(value: null),
          'DonGia': TrinaCell(value: null),
          'ThanhTien': TrinaCell(value: null),
          'TKKho': TrinaCell(value: null),
          'TKgv': TrinaCell(value: null),
        },
      ),
    ]);
  }

  void setMode(bool khoa){
    if(khoa){
      _stateManager.setGridMode(TrinaGridMode.readOnly);
    }else{
      _stateManager.setGridMode(TrinaGridMode.normal);

    }
  }

  List<PhieuXuatCTModel> toList(int phieuXuatId){
    return _stateManager.rows.map((e)=>PhieuXuatCTModel(

        dvt: e.cells['DVT']?.value,
        donGia: e.cells['DonGia']?.value,
        hangHoaId: e.cells['MaHH']?.value,
        phieuXuatId: phieuXuatId,
        soLg: e.cells['SoLg']?.value,
        tenHH: e.cells['TenHH']?.value,
        thanhTien: e.cells['ThanhTien']?.value,
        tkKho: e.cells['TKKho']?.value,
        tkgv: e.cells['TKgv']?.value
    )).toList();
  }

  num tongTienHang(){
    num tong = 0;
    for(var x in _stateManager.rows){
      tong += x.cells['ThanhTien']?.value;
    }
    return tong;
  }
}