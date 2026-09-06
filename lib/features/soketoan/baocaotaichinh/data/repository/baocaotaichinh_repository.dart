import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_cdps_model.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_tmp_model.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/repository/ibaocaotaichinh_repository.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socttk_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final baoCaoTaiChinhRepositoryProvider = Provider<IBaoCaoTaiChinhRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return BaoCaoTaiChinhRepository(dio);
});

class BaoCaoTaiChinhRepository implements IBaoCaoTaiChinhRepository{
  
  final Dio _dio;

  BaoCaoTaiChinhRepository(this._dio);
  
  
  
  @override
  Future<List<BangCDPSModel>> getViewCDPS(int kieu) async {
    // TODO: implement getViewCDPS
    try{
      final response = await _dio.get("/BaoCaoTaiChinh/get-view-cdps/$kieu");
      final data = response.data as List;
      return data.map((e)=>BangCDPSModel.fromMap((e))).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<BangCDPSModel>> tinhToanCDPS(int kieu, DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement tinhToanCDPS
    try{
      final response = await _dio.post("/BaoCaoTaiChinh/tinh-toan-cdps/$kieu", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as List;
      return data.map((e)=>BangCDPSModel.fromMap((e))).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<bool> luuSoDuCDPS(String thang) async {
    // TODO: implement luuSoDuCDPS
    try{
      final response = await _dio.post("/BaoCaoTaiChinh/luu-sd-cdps/$thang");
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<SoCTTKModel>> getViewCTTK(String maTK, String year) async {
    // TODO: implement getViewCTTK
    try{
      final response = await _dio.get("/BaoCaoTaiChinh/get-view-cttk/$maTK", queryParameters: {
        'year': year
      });
      final data = response.data as List;
      return data.map((e)=>SoCTTKModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<BangTmpModel>> getBCTC(String form, int year) async{
    // TODO: implement getBCTC
    try{
      final response = await _dio.get("/BaoCaoTaiChinh/get-bao-cao-tai-chinh/$form", queryParameters: {
        'year': year
      });
      final data = response.data as List;
      return data.map((e)=>BangTmpModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> luuBaoCao(String form, int year) async {
    // TODO: implement luuBaoCao
    try{
      await _dio.post("/BaoCaoTaiChinh/luu-bao-bao/$form", queryParameters: {
        'year': year
      });

    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
  
}