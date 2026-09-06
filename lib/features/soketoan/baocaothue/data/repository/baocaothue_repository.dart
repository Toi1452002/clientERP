import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tncn_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_tt_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/ibaocaothue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final baoCaoThueRepositoryProvider = Provider<IBaoCaoThueRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return BaoCaoThueRepository(dio);
});

class BaoCaoThueRepository implements IBaoCaoThueRepository{
  final Dio _dio;

  BaoCaoThueRepository(this._dio);
  
  @override
  Future<List<TNDNttModel>> getViewTNDNtt(int year, int quy) async {
    // TODO: implement getView
    try{
      final response = await _dio.get("/BaoCaoThue/tndn-tam-tinh",queryParameters: {
        'year': year,
        'quy': quy
      });
      final data = response.data as List;
      return data.map((e)=>TNDNttModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<TNDNModel>> getViewTNDN(int year) async {
    // TODO: implement getViewTNDN
    try{
      final response = await _dio.get("/BaoCaoThue/tndn",queryParameters: {
        'year': year,
      });
      final data = response.data as List;
      return data.map((e)=>TNDNModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<TNCNModel>> getViewTNCN(int year, int quy) async{
    // TODO: implement getViewTNCN
    try{
      final response = await _dio.get("/BaoCaoThue/tncn",queryParameters: {
        'year': year,
        'quy':  quy
      });
      final data = response.data as List;
      return data.map((e)=>TNCNModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
}