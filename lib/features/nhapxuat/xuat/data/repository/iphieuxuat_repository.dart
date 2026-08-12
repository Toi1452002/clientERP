import '../model/phieuxuat_request_model.dart';
import '../model/phieuxuat_update_model.dart';

abstract interface class IPhieuXuatRepository{
  Future<PhieuXuatRequestModel?> getLast();
  Future<PhieuXuatRequestModel?> getFirst();
  Future<PhieuXuatRequestModel?> getNext(int id);
  Future<PhieuXuatRequestModel?> getPrevious(int id);
  Future<PhieuXuatRequestModel?> getByPhieu(String maPhieu);

  Future<PhieuXuatRequestModel> add();

  Future<void> update(PhieuXuatUpdateModel x, int id);

  Future<void> updateKhoa(int phieuXuatId);

  Future<void> delete(int id);
}