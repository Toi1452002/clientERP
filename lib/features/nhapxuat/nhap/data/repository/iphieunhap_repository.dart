import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhap_response_model.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhap_update_model.dart';

abstract interface class IPhieuNhapRepository{
  Future<PhieuNhapRequestModel?> getLast();
  Future<PhieuNhapRequestModel?> getFirst();
  // Future<PhieuNhapRequestModel?> getNext(int id);
  // Future<PhieuNhapRequestModel?> getPrevious(int id);
  Future<PhieuNhapRequestModel?> getById(int id);
  Future<PhieuNhapRequestModel?> getByPhieu(String maPhieu);

  Future<PhieuNhapRequestModel> add();

  Future<void> update(PhieuNhapUpdateModel x, int id);

  Future<void> updateKhoa(int phieuNhapId);

  Future<void> delete(int id);
}