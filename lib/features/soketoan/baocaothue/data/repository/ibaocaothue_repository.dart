import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tncn_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_tt_model.dart';

import '../model/tndn_model.dart';

abstract interface class IBaoCaoThueRepository{
  Future<List<TNDNttModel>> getViewTNDNtt(int year, int quy);
  Future<List<TNDNModel>> getViewTNDN(int year);
  Future<List<TNCNModel>> getViewTNCN(int year, int quy);
}