
import '../model/nhomhang_model.dart';

abstract interface class INhomHangRepository{
  Future<List<NhomHangModel>> getAll();

  Future<NhomHangModel> add(String nhomHang);

  Future<NhomHangModel> update(int id, String nhomHang);

  Future<int> delete(int id);
}