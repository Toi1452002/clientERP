import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/taisan/ccdc/data/model/ccdc_update_model.dart';
import 'package:erp_client_1/features/taisan/ccdc/data/model/ccdc_view_model.dart';
import 'package:erp_client_1/features/taisan/ccdc/data/repository/iccdc_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';
import '../../../../../core/utils/date_helper.dart';

final ccdcRepositoryProvider = Provider<ICCDCRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return CCDCRepository(dio);
});

class CCDCRepository implements ICCDCRepository{
  final Dio _dio;

  CCDCRepository(this._dio);
  @override
  Future<CCDCViewModel> addRow() async {
    // TODO: implement addRow
    try{
      final response = await _dio.post("/CCDC");
      final data = response.data as Map<String, dynamic>;
      return CCDCViewModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async{
    // TODO: implement delete
    try{
      final response = await _dio.delete("/CCDC/$id");
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<CCDCViewModel>> getView() async {
    // TODO: implement getView
    try{
      final response = await _dio.get("/CCDC");
      final data = response.data as List;
      return data.map((e)=>CCDCViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<CCDCViewModel>> tinhToan(DateTime ngay)async {
    // TODO: implement tinhToan
    try{
      final response = await _dio.get("/CCDC/tinh-toan", queryParameters: {
        'ngay':DateHelper.yMd(ngay)
      });
      final data = response.data as List;
      return data.map((e)=>CCDCViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<CCDCViewModel> updateRow(int id, CCDCUpdateModel model, {bool isHH = false}) async {
    // TODO: implement updateRow
    try{
      final response = await _dio.put("/CCDC/$id", data: model.toMap(),queryParameters: {
        'isHH': isHH
      });
      final data = response.data as Map<String, dynamic>;
      return CCDCViewModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
}