import 'package:erp_client_1/features/ketchuyen/data/model/buttoan_model.dart';
import 'package:erp_client_1/features/ketchuyen/data/model/ketchuyen_view_model.dart';

abstract interface class IKetChuyenRepository{
  Future<List<ButToanModel>> getLookupButToan();
  Future<List<KetChuyenViewModel>> getViewKetChuyen(DateTime tuNgay, DateTime denNgay);
  Future<int> add();
  Future<int> delete(int id);
  Future<int> update(KetChuyenViewModel model, int id);
  Future<List<KetChuyenViewModel>> ketChuyenTrinhTu(DateTime tuNgay, DateTime denNgay, String butToan);
  Future<List<KetChuyenViewModel>> ketChuyenTheoThang(DateTime tuNgay, DateTime denNgay);
  Future<List<KetChuyenViewModel>> ketChuyenTheoNam(DateTime tuNgay, DateTime denNgay);
}