import '../model/khach_edit_model.dart';
import '../model/khach_lookup_model.dart';
import '../model/khach_request_model.dart';
import '../model/khach_view_model.dart';

abstract interface class IKhachRepository{
  Future<List<KhachViewModel>> getView();

  Future<int> add(KhachRequestModel khach);

  Future<KhachEditModel> getById(int id);

  Future<void> update(KhachRequestModel khach, int id);

  Future<bool> delete(int id);

  Future<List<KhachLookupModel>> getNhaCung();
  Future<List<KhachLookupModel>> getKhach();

}