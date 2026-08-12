import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_edit_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_lookup_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_request_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/model/khach_view_model.dart';
import 'package:erp_client_1/features/danhmuc/khach/data/repository/ikhach_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';

final khachRepositoryProvider = Provider<IKhachRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return KhachRepository(dio);
});

class KhachRepository implements IKhachRepository {
  final Dio _dio;

  KhachRepository(this._dio);

  @override
  Future<int> add(KhachRequestModel khach) async {
    // TODO: implement add
    try{
      final response = await _dio.post("/KhachHang",data: khach.toMap());
      if(response.statusCode == 200){
        return response.data;
      }
      return 0;
    }on DioException catch (e){
      throw ApiException.handleDioException(e);
    }catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    try{
      final response =  await _dio.delete("/KhachHang/$id");
      return response.data > 0;
    }on DioException catch (e){
      throw ApiException.handleDioException(e);
    }catch (e) {
      rethrow;
    }
  }

  @override
  Future<KhachEditModel> getById(int id) async {
    // TODO: implement getById
    try{
      final response = await _dio.get("/KhachHang/$id");
      final data = response.data as Map<String, dynamic>;
      return KhachEditModel.fromMap(data);
    }on DioException catch (e){
      throw ApiException.handleDioException(e);
    }catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<KhachLookupModel>> getNhaCung() async {
    // TODO: implement getNhaCung
    try{
      final response = await _dio.get("/KhachHang/NC");
      final data = response.data as List;
      return data.map((e)=> KhachLookupModel.fromMap(e)).toList();
    }on DioException catch (e){
      throw ApiException.handleDioException(e);
    }catch (e) {
      rethrow;
    }
  }
  @override
  Future<List<KhachLookupModel>> getKhach() async {
    // TODO: implement getKhach
    try{
      final response = await _dio.get("/KhachHang/KH");
      final data = response.data as List;
      return data.map((e)=> KhachLookupModel.fromMap(e)).toList();
    }on DioException catch (e){
      throw ApiException.handleDioException(e);
    }catch (e) {
      rethrow;
    }
  }
  @override
  Future<List<KhachViewModel>> getView() async {
    // TODO: implement getView
    try {
      final response = await _dio.get("/KhachHang");
      final data = response.data as List;
      return data.map((e) => KhachViewModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update(KhachRequestModel khach, int id) async {
    // TODO: implement update
    try{
      await _dio.put("/KhachHang/$id",data: khach.toMap());
    }on DioException catch (e){
      throw ApiException.handleDioException(e);
    }catch (e) {
      rethrow;
    }
  }
}
