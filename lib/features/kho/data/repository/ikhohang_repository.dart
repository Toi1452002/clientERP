import 'package:erp_client_1/features/kho/data/model/bke_nhapxuat_model.dart';
import 'package:erp_client_1/features/kho/data/model/nhapxuatton_model.dart';

abstract interface class IKhoHangRepository{
  Future<List<BKeNhapXuatModel>> getBKeHangNhap(DateTime tuNgay, DateTime denNgay);
  Future<List<BKeNhapXuatModel>> getBKeHangXuat(DateTime tuNgay, DateTime denNgay);
  Future<List<NhapXuatTonModel>> getNhapXuatTon(DateTime tuNgay, DateTime denNgay, String maTK);
}