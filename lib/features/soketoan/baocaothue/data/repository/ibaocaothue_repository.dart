import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_ct_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/phat_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/sothue_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tncn_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_tt_model.dart';

import '../model/tndn_model.dart';

abstract interface class IBaoCaoThueRepository {
  Future<List<TNDNttModel>> getViewTNDNtt(int year, int quy);

  Future<List<TNDNModel>> getViewTNDN(int year);

  Future<List<TNCNModel>> getViewTNCN(int year, int quy);

  Future<List<ChuyenLoModel>> getViewChuyenLo();

  Future<List<ChuyenLoCTModel>> getViewChuyenLoCT(int chuyenLoId, int year);

  Future<void> updateChuyenLoCT(Map<String, dynamic> data, int id);

  Future<List<SoThueModel>> getViewSoThue(String loaiThue);

  Future<SoThueModel> tinhGTGT(int year, int soThueId);
  Future<SoThueModel> tinhTNCN(int year, int id);
  Future<SoThueModel> tinhTNDN(int year, int id);
  Future<void> updateGTGT(UpdateGTGTModel model, int id);
  Future<void> updateTNDN(UpdateTNDNModel model, int id);
  Future<void> updateTNCN(UpdateTNCNModel model, int id);

  Future<List<PhatModel>> getViewPhat();
  Future<PhatModel> addRowPhat();
  Future<void> updatePhat(PhatModel model);


}
