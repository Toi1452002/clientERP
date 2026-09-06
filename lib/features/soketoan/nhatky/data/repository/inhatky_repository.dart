import 'package:erp_client_1/features/soketoan/nhatky/data/model/nhatkychung_model.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socaitk_model.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socttk_model.dart';

abstract interface class INhatKyRepository{
  Future<List<NhatKyChungModel>> getNhatKyChung(DateTime tuNgay, DateTime denNgay);
  Future<SoCaiTKViewModel> getSoCaiTK(String maTK, DateTime tuNgay, DateTime denNgay);
  Future<SoCTTKViewModel> getSoCTTK(String maTK, DateTime tuNgay, DateTime denNgay);
}