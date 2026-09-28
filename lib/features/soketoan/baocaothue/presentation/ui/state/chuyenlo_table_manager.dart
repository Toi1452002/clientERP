import 'package:erp_client_1/core/widgets/app_table/app_table_state.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_ct_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_model.dart';
import 'package:trina_grid/trina_grid.dart';

class ChuyenLoTableManager extends AppTableState<ChuyenLoModel>{
  final TrinaGridStateManager _stateManager;

  ChuyenLoTableManager(this._stateManager);

  @override
  void loadView(List<ChuyenLoModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'stt': TrinaCell(value: e.id),
      'NamBC': TrinaCell(value: e.namBC),
      'LoiNhuan': TrinaCell(value: e.loiNhuan),
      'SoLuyKe': TrinaCell(value: e.soLuyKe),
      'NopThue': TrinaCell(value: e.nopThue),
      'Q1': TrinaCell(value: e.q1),
      'Q2': TrinaCell(value: e.q2),
      'Q3': TrinaCell(value: e.q3),
      'Q4': TrinaCell(value: e.q4),
    })).toList());
  }

}

class ChuyenLoCTTableManager extends AppTableState<ChuyenLoCTModel>{
  final TrinaGridStateManager _stateManager;

  ChuyenLoCTTableManager(this._stateManager);

  @override
  void loadView(List<ChuyenLoCTModel> data) {
    // TODO: implement loadView
    _stateManager.removeAllRows();
    _stateManager.appendRows(data.map((e)=>TrinaRow(cells: {
      'null': TrinaCell(),
      'Id': TrinaCell(value: e.id),
      'ConLo': TrinaCell(value: e.conLo),
      'NamPSlo': TrinaCell(value: e.namPSLo),
      'SoLoPS': TrinaCell(value: e.soLoPS),
      'LoDaChuyenKyTruoc': TrinaCell(value: e.loDaChuyenKyTruoc),
      'LoDuocChuyenKyNay': TrinaCell(value: e.loDuocChuyenKyNay),
      'LoDuocChuyenKySau': TrinaCell(value: e.loDuocChuyenKySau),
    })).toList());
  }

}