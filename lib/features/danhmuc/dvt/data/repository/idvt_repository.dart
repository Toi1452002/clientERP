
import 'package:erp_client_1/features/danhmuc/dvt/data/model/dvt_model.dart';

abstract interface class IDvtRepository{
  Future<List<DvtModel>> getAll() ;

  Future<void> add(String dvt);

  Future<void> update(int id, String dvt);

  Future<void> delete(int id);
}