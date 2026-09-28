import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/data/model/hanghoa_lookup_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';
import '../../../../../core/data/network/network_service.dart';
import '../model/hanghoa_model.dart';
import '../model/hanghoaview_model.dart';
import '../model/loaihang_model.dart';
import 'ihanghoa_repository.dart';

final hangHoaRepositoryProvider = Provider<IHangHoaRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return HangHoaRepository(dio);
});

class HangHoaRepository implements IHangHoaRepository{
  final Dio _dio;
  HangHoaRepository(this._dio);
  
  @override
  Future<List<HangHoaViewModel>> getView({bool? isActive}) async {
    // TODO: implement getView
    try{
      final response = await _dio.get("/HangHoa", queryParameters: {
        'isActive': isActive
      });
      final data = response.data as List;
      return data.map((e)=>HangHoaViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<LoaiHangModel>> getLoaiHang() async{
    // TODO: implement getLoaiHang
    try{
      final response = await _dio.get("/HangHoa/LH");
      final data = response.data as List;
      return data.map((e)=>LoaiHangModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<HangHoaViewModel> add(HangHoaModel hangHoa) async {
    // TODO: implement add
    try{
      final response = await _dio.post("/HangHoa",data: hangHoa.toMap());
      final data = response.data as Map<String, dynamic>;
      return HangHoaViewModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<HangHoaModel> getById(int id) async {
    // TODO: implement getById
    try{
      final response = await _dio.get("/HangHoa/$id");
      final data = response.data as Map<String, dynamic>;
      return HangHoaModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<HangHoaViewModel> update(HangHoaModel hangHoa, int id) async{
    // TODO: implement update
    try{
     final response = await _dio.put("/HangHoa/$id",data: hangHoa.toMap());
     final data = response.data as Map<String, dynamic>;
     return HangHoaViewModel.fromMap(data);
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
     final response =  await _dio.delete("/HangHoa/$id");
     return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<HangHoaLookupModel>> getLookup()  async{
    // TODO: implement getLookup
    try{
     final response =  await _dio.get("/HangHoa/lookup");
     final data = response.data as List;
     return data.map((e)=>HangHoaLookupModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

}