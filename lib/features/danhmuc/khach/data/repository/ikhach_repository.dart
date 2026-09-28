import '../model/khach_edit_model.dart';
import '../model/khach_lookup_model.dart';
import '../model/khach_request_model.dart';
import '../model/khach_view_model.dart';

abstract interface class IKhachRepository{
  Future<List<KhachViewModel>> getView({bool? isActive});

  Future<KhachViewModel> add(KhachRequestModel khach);

  Future<KhachEditModel> getById(int id);

  Future<KhachViewModel> update(KhachRequestModel khach, int id);

  Future<int> delete(int id);

  Future<List<KhachLookupModel>> getNhaCung();
  Future<List<KhachLookupModel>> getKhach();

}