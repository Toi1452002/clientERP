
import '../model/nhomhang_model.dart';

abstract interface class INhomHangRepository{
  Future<List<NhomHangModel>> getAll();

  Future<void> add(String nhomHang);

  Future<void> update(int id, String nhomHang);

  Future<void> delete(int id);
}