import 'package:erp_client_1/features/thuchi/thu/data/model/phieuthu_model.dart';
import 'package:erp_client_1/features/thuchi/thu/data/model/phieuthu_save_model.dart';

abstract interface class IThuRepository {
  Future<PhieuThuModel?> getLastPhieu();

  Future<PhieuThuModel?> getFirstPhieu();

  // Future<PhieuThuModel?> getPrevious(int id);
  //
  // Future<PhieuThuModel?> getNext(int id);

  Future<PhieuThuModel?> getByPhieu(String phieu);

  Future<PhieuThuModel?> getById(int id);

  Future<int> onSave(PhieuThuSaveModel pt, int id);

  Future<int> updateEdit(int id);

  Future<PhieuThuModel> add();

  Future<int> delete(int id);
}
