import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/system/roles/data/model/role_model.dart';
import 'package:erp_client_1/features/system/roles/data/repository/irole_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roleRepositoryProvider = Provider<IRoleRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return RoleRepository(dio);
});

class RoleRepository implements IRoleRepository{
  final Dio _dio;
  RoleRepository(this._dio);
  
  
  @override
  Future<int> add(String roleName)async {
    // TODO: implement add
    try{
      final response = await _dio.post("/role", queryParameters: {"roleName": roleName});
      final data = response.data;
      return data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> delete(int id)async {
    // TODO: implement delete
    try{
      final response = await _dio.delete("/role/$id",);
      final data = response.data;
      return data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<RoleModel>> getView() async {
    try{
      final response = await _dio.get("/role");
      final data = response.data as List;
      return data.map((e)=>RoleModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> update(String roleName, int id)async {
    // TODO: implement update
    try{
      final response = await _dio.patch("/role/$id",queryParameters: {"roleName": roleName});
      final data = response.data;
      return data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
}