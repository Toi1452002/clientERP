import 'package:erp_client_1/features/tienluong/chamcong/data/model/chamcong_view_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/macc_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/update_socong_model.dart';

abstract interface class IChamCongRepository{
  Future<List<ChamCongViewModel>> getView(int month, int year);

  Future<List<MaCCModel>> getListMaCC();

  Future<num> updateSoCong(UpdateSoCongModel model);

  Future<int> addRow(int month, int year);

  Future<int> delete(int id);

  Future<void> updateMaNV(String maNV, int id);
}