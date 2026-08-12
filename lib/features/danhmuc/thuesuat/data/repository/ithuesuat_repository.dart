import 'package:erp_client_1/features/danhmuc/thuesuat/data/model/thuesuat_model.dart';

abstract interface class IThueSuatRepository{
  Future<List<ThueSuatModel>> getLookup();
}