import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_request_model.dart';

abstract interface class IMaNghiepVuRepository {
  Future<int> add(MaNghiepVuRequestModel model);

  // Future<int> update(MaNghiepVuRequestModel model, int id);
  Future<int> updateMaNV(String ma, int id);
  Future<int> updateMoTa(String moTa, int id);

  Future<int> delete(int id);

  Future<List<MaNghiepVuModel>> getView();

  Future<List<MaNghiepVuModel>> getT();

  Future<List<MaNghiepVuModel>> getC();

  Future<List<MaNghiepVuModel>> getN();

  Future<List<MaNghiepVuModel>> getX();
}
