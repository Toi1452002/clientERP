import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/danhmuc/thuesuat/data/model/thuesuat_model.dart';
import 'package:erp_client_1/features/danhmuc/thuesuat/data/repository/ithuesuat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final thueSuatRepositoryProvider = Provider<IThueSuatRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return ThueSuatRepository(dio);
});

class ThueSuatRepository implements IThueSuatRepository{
  final Dio _dio;
  ThueSuatRepository(this._dio);

  @override
  Future<List<ThueSuatModel>> getLookup() async {
    // TODO: implement getLookup
    try{
      final response = await _dio.get("/ThueSuat");
      final data = response.data as List;
      return data.map((e)=>ThueSuatModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

}