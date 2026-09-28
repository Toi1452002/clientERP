import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_ct_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/phat_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tncn_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/tndn_tt_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/repository/ibaocaothue_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/sothue_model.dart';

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

  @override
  Future<List<ChuyenLoModel>> getViewChuyenLo() async {
    // TODO: implement getViewChuyenLo
    try{
      final response = await _dio.get("/BaoCaoThue/chuyen-lo");
      final data = response.data as List;
      return data.map((e)=>ChuyenLoModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<ChuyenLoCTModel>> getViewChuyenLoCT(int chuyenLoId, int year) async{
    // TODO: implement getViewChuyenLoCT
    try{
      final response = await _dio.get("/BaoCaoThue/chuyen-lo-ct/$chuyenLoId",queryParameters: {
        'year': year
      });
      final data = response.data as List;
      return data.map((e)=>ChuyenLoCTModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> updateChuyenLoCT(Map<String, dynamic> map, int id) async {
    // TODO: implement updateChuyenLoCT
    try{
       await _dio.put("/BaoCaoThue/chuyen-lo-ct/$id",data: map);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<SoThueModel>> getViewSoThue(String loaiThue) async {
    // TODO: implement getViewSoThue
    try{
      final response = await _dio.get("/BaoCaoThue/so-thue/$loaiThue");
      final data = response.data as List;
      return data.map((e)=>SoThueModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SoThueModel> tinhGTGT(int year, int soThueId) async {
    // TODO: implement tinhGTGT
    try{
      final response = await _dio.get("/BaoCaoThue/so-thue/tinh-GTGT",queryParameters: {
        'year': year,
        'id': soThueId
      });
      final data = response.data as Map<String, dynamic>;
      return SoThueModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> updateGTGT(UpdateGTGTModel model, int id) async{
    // TODO: implement updateGTGT
    try{
      await _dio.put("/BaoCaoThue/so-thue/update-GTGT/$id",data: model.toMap());
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SoThueModel> tinhTNCN(int year, int id) async{
    // TODO: implement tinhTNCN
    try{
      final response = await _dio.get("/BaoCaoThue/so-thue/tinh-TNCN",queryParameters: {
        'year': year,
        'id': id
      });
      final data = response.data as Map<String, dynamic>;
      return SoThueModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SoThueModel> tinhTNDN(int year, int id) async{
    // TODO: implement tinhTNDN
    try{
      final response = await _dio.get("/BaoCaoThue/so-thue/tinh-TNDN",queryParameters: {
        'year': year,
        'id': id
      });
      final data = response.data as Map<String, dynamic>;
      return SoThueModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> updateTNCN(UpdateTNCNModel model, int id) async{
    // TODO: implement updateTNCN
    try{
      await _dio.put("/BaoCaoThue/so-thue/update-TNCN/$id",data: model.toMap());
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> updateTNDN(UpdateTNDNModel model, int id) async {
    // TODO: implement updateTNDN
    try{
      await _dio.put("/BaoCaoThue/so-thue/update-TNDN/$id",data: model.toMap());
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<PhatModel>> getViewPhat() async{
    // TODO: implement getViewPhat
    try{
      final response = await _dio.get("/BaoCaoThue/so-thue/phat");
      final data = response.data as List;
      return data.map((e)=>PhatModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhatModel> addRowPhat() async {
    // TODO: implement addRowPhat
    try{
      final response = await _dio.post("/BaoCaoThue/so-thue/phat");
      final data = response.data as Map<String, dynamic>;
      return PhatModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> updatePhat(PhatModel model) async{
    // TODO: implement updatePhat
    try{
      await _dio.put("/BaoCaoThue/so-thue/phat",data: model.toMap());

    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
}