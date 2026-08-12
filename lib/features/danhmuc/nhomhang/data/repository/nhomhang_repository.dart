import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';
import '../../../../../core/data/network/network_service.dart';
import '../model/nhomhang_model.dart';
import 'inhomhang_repository.dart';

final nhomHangRepositoryProvider = Provider<INhomHangRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return NhomHangRepository(dio);
});

class NhomHangRepository implements INhomHangRepository{
  final Dio _dio;
  NhomHangRepository(this._dio);
  
  @override
  Future<List<NhomHangModel>> getAll() async {
    try{
      final response = await _dio.get("/NhomHang");
      final data = response.data as List;
      return data.map((e)=> NhomHangModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }
  @override
  Future<void> add(String nhomHang) async {
    // TODO: implement add
    try {
      await _dio.post("/NhomHang", queryParameters: {'nhomHang': nhomHang});
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<void> delete(int id) async {
    // TODO: implement delete
    try {
      await _dio.delete("/NhomHang/$id");
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<void> update(int id, String nhomHang) async{
    try {
      await _dio.patch("/NhomHang/$id",queryParameters: {'nhomHang': nhomHang});
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }
}