import 'package:dio/dio.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_request_model.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/data/model/taikhoan_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';
import '../../../../../core/data/network/network_service.dart';
import '../model/taikhoan_lookup_model.dart';
import 'itaikhoan_repository.dart';

final taiKhoanRepositoryProvider = Provider<ITaiKhoanRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return TaiKhoanRepository(dio);
});

class TaiKhoanRepository implements ITaiKhoanRepository{
  final Dio _dio;

  TaiKhoanRepository(this._dio);

  @override
  Future<List<TaiKhoanLookupModel>> getKhoND() async {
    // TODO: implement getKhoND
    try{
      final response = await _dio.get("/TaiKhoan/kho-nd");
      final data = response.data as List;
      return data.map((e)=> TaiKhoanLookupModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<List<TaiKhoanLookupModel>> getMaXL0() async {
    // TODO: implement getMaXL0
    try{
      final response = await _dio.get("/TaiKhoan/maxl-0");
      final data = response.data as List;
      return data.map((e)=> TaiKhoanLookupModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<List<TaiKhoanLookupModel>> getTKCoPx()async {
    // TODO: implement getTKCoPx
    try{
      final response = await _dio.get("/TaiKhoan/tk-co-px");
      final data = response.data as List;
      return data.map((e)=> TaiKhoanLookupModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<List<TaiKhoanLookupModel>> getTKNoPx()async {
    // TODO: implement getTKNoPx
    try{
      final response = await _dio.get("/TaiKhoan/tk-no-px");
      final data = response.data as List;
      return data.map((e)=> TaiKhoanLookupModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<List<TaiKhoanViewModel>> getView() async {
    // TODO: implement getView
    try{
      final response = await _dio.get("/TaiKhoan");
      final data = response.data as List;
      return data.map((e)=> TaiKhoanViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<int> add(TaiKhoanRequestModel model) async{
    // TODO: implement add
    try{
      final response = await _dio.post("/TaiKhoan",data: model.toMap());
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<int> delete(int id) async{
    // TODO: implement delete
    try{
      final response = await _dio.delete("/TaiKhoan/$id");
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<TaiKhoanViewModel?> getEdit(int id) async {
    // TODO: implement getEdit
    try{
      final response = await _dio.get("/TaiKhoan/$id");
      final data = response.data as Map<String, dynamic>;
      return TaiKhoanViewModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<int> update(TaiKhoanRequestModel model, int id) async{
    // TODO: implement update
    try{
      final response = await _dio.put("/TaiKhoan/$id",data: model.toMap());
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

  @override
  Future<List<TaiKhoanLookupModel>> getTKSoCai() async {
    // TODO: implement getTKSoCai
    try{
      final response = await _dio.get("/TaiKhoan/tk-so-cai");
      final data = response.data as List;
      return data.map((e)=> TaiKhoanLookupModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      throw Exception("Unknown error");
    }
  }

}