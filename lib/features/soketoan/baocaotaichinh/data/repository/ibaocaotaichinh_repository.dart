import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_cdps_model.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_tmp_model.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socttk_model.dart';

abstract interface class IBaoCaoTaiChinhRepository {
  Future<List<BangCDPSModel>> getViewCDPS(int kieu);

  Future<List<BangCDPSModel>> tinhToanCDPS(int kieu, DateTime tuNgay, DateTime denNgay);

  Future<bool> luuSoDuCDPS(String thang,{bool nam = false});

  Future<List<SoCTTKModel>> getViewCTTK(String maTK, String year);

  Future<List<BangTmpModel>> getBCTC(String form, int year);

  Future<void> luuBaoCao(String form, int year);
}
