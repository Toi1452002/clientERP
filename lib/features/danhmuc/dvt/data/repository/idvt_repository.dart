
import 'package:erp_client_1/features/danhmuc/dvt/data/model/dvt_model.dart';

abstract interface class IDvtRepository{
  Future<List<DvtModel>> getAll() ;

  Future<DvtModel> add(String dvt);

  Future<DvtModel> update(int id, String dvt);

  Future<int> delete(int id);
}