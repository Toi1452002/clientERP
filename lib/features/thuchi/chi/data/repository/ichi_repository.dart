import '../model/phieuchi_model.dart';
import '../model/phieuchi_save_model.dart';

abstract interface class IChiRepository {
  Future<PhieuChiModel?> getLastPhieu();

  Future<PhieuChiModel?> getFirstPhieu();

  // Future<PhieuChiModel?> getPrevious(int id);
  //
  // Future<PhieuChiModel?> getNext(int id);
  Future<PhieuChiModel?> getByPhieu(String phieu);
  Future<PhieuChiModel?> getById(int id);

  Future<int> onSave(PhieuChiSaveModel pc, int id);

  Future<int> updateEdit(int id);

  Future<PhieuChiModel> add();

  Future<int> delete(int id);
}
