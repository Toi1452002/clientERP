

import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/system/ttdn/data/model/ttdn_model.dart';
import 'package:erp_client_1/features/system/ttdn/data/repository/ittdn_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ttdnRepositoryProvider = Provider<ITTDNRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return TTDNRepository(dio);
});

class TTDNRepository implements ITTDNRepository{
  final Dio _dio;
  
  TTDNRepository(this._dio);
  
  @override
  Future<List<TTDNModel>> getView() async {
    // TODO: implement getView
    try{
      final response = await _dio.get("/TTDN");
      final data = response.data as List;
      return data.map((e)=>TTDNModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> updateNoiDung(String noiDung, int id) async {
    // TODO: implement updateNoiDung
    try{
      final response = await _dio.patch("/TTDN/$id",data: {'noiDung': noiDung});
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
}