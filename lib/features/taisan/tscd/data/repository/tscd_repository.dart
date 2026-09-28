import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/taisan/tscd/data/model/tscd_update_model.dart';
import 'package:erp_client_1/features/taisan/tscd/data/model/tscd_view_model.dart';
import 'package:erp_client_1/features/taisan/tscd/data/repository/itscd_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tscdRepositoryProvider = Provider<ITSCDRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return TSCDRepository(dio);
});

class TSCDRepository implements ITSCDRepository{
  final Dio _dio;

  TSCDRepository(this._dio);
  
  @override
  Future<TSCDViewModel> addRow() async {
    // TODO: implement addRow
    try{
      final response = await _dio.post("/TSCD");
      final data = response.data as Map<String, dynamic>;
      return TSCDViewModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    // TODO: implement delete
    try{
      final response = await _dio.delete("/TSCD/$id");
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<TSCDViewModel>> getView() async {
    // TODO: implement getView
    try{
      final response = await _dio.get("/TSCD");
      final data = response.data as List;
      return data.map((e)=>TSCDViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<TSCDViewModel>> tinhToan(DateTime ngay) async {
    // TODO: implement tinhToan
    try{
      final response = await _dio.get("/TSCD/tinh-toan", queryParameters: {
        'ngay':DateHelper.yMd(ngay)
      });
      final data = response.data as List;
      return data.map((e)=>TSCDViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<TSCDViewModel> updateRow(int id, TSCDUpdateModel model, {bool isHH = false}) async {
    // TODO: implement updateRow
    try{
      final response = await _dio.put("/TSCD/$id", data: model.toMap(),queryParameters: {
        'isHH': isHH
      });
      final data = response.data as Map<String, dynamic>;
      return TSCDViewModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
}