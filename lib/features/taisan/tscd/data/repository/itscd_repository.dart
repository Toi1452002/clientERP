import 'package:erp_client_1/features/taisan/tscd/data/model/tscd_update_model.dart';
import 'package:erp_client_1/features/taisan/tscd/data/model/tscd_view_model.dart';

abstract interface class ITSCDRepository {
  Future<List<TSCDViewModel>> getView();

  Future<TSCDViewModel> addRow();

  Future<TSCDViewModel> updateRow(int id, TSCDUpdateModel model, {bool isHH = false});

  Future<int> delete(int id);

  Future<List<TSCDViewModel>> tinhToan(DateTime ngay);
}
