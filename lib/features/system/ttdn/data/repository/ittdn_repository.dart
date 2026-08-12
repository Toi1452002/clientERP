import 'package:erp_client_1/features/system/ttdn/data/model/ttdn_model.dart';

abstract interface class ITTDNRepository{
  Future<List<TTDNModel>> getView();

  Future<int> updateNoiDung(String noiDung, int id);
}