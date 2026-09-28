import 'dart:math';

import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/sothue_model.dart';
import 'package:trina_grid/trina_grid.dart';

class SoThueTableManager extends AppTableState<SoThueModel>{
  final TrinaGridStateManager _stateManager;
  bool isInit = false;

  SoThueTableManager(this._stateManager);
  @override
  void loadView(List<SoThueModel> data) {
    // TODO: implement loadView
    isInit = true;
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(),
      'Nam': TrinaCell(value: e.nam),
      'SoKyTruoc': TrinaCell(value: e.soKyTruoc),
      'SoBaoCao': TrinaCell(value: e.soBaoCao),
      'SoKiemTra': TrinaCell(value: e.soKiemTra),
      'SoPhaiNop': TrinaCell(value: e.soPhaiNop),
      'SoDaNop': TrinaCell(value: e.soDaNop),
      'ConPhaiNop': TrinaCell(value: e.conPhaiNop),
      'Tinh': TrinaCell(value: e.id),
    })).toList());
  }
  void showLoading(){
    _stateManager.setShowLoading(true);
  }

  void closeLoading(){
    _stateManager.setShowLoading(false);
  }

  UpdateGTGTModel toModelGTGT(TrinaGridOnChangedEvent event) {
    return UpdateGTGTModel(
      soBaoCao: event.row.cells['SoBaoCao']?.value,
      soDaNop: event.row.cells['SoDaNop']?.value
    );
  }
  UpdateTNDNModel toModelTNDN(TrinaGridOnChangedEvent event) {
    return UpdateTNDNModel(
        soBaoCao: event.row.cells['SoBaoCao']?.value,
        soDaNop: event.row.cells['SoDaNop']?.value,
      soKiemTra: event.row.cells['SoKiemTra']?.value,
      soPhaiNop: event.row.cells['SoPhaiNop']?.value,
    );
  }
  UpdateTNCNModel toModelTNCN(TrinaGridOnChangedEvent event) {
    return UpdateTNCNModel(
      soBaoCao: event.row.cells['SoBaoCao']?.value,
      soDaNop: event.row.cells['SoDaNop']?.value,
      soKiemTra: event.row.cells['SoKiemTra']?.value,
    );
  }
}