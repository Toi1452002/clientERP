import '../model/ccdc_update_model.dart';
import '../model/ccdc_view_model.dart';

abstract interface class ICCDCRepository {
  Future<List<CCDCViewModel>> getView();

  Future<CCDCViewModel> addRow();

  Future<CCDCViewModel> updateRow(int id, CCDCUpdateModel model, {bool isHH = false});

  Future<int> delete(int id);

  Future<List<CCDCViewModel>> tinhToan(DateTime ngay);
}