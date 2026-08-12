import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/congno/data/model/sobanhang_view_model.dart';
import 'package:erp_client_1/features/congno/data/model/somuahang_view_model.dart';
import 'package:erp_client_1/features/congno/data/model/tonghop_congno_model.dart';
import 'package:erp_client_1/features/congno/data/repository/icongno_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final congNoRepositoryProvider = Provider<ICongNoRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return CongNoRepository(dio);
});

class CongNoRepository implements ICongNoRepository{
  final Dio _dio;

  CongNoRepository(this._dio);
  
  
  @override
  Future<SoMuaHangViewModel> getSoMuaHang(String? maKH, DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement getSoMuaHang
    try{
      final response = await _dio.get("/CongNo/so-mua-hang/$maKH", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as Map<String, dynamic>;
      return SoMuaHangViewModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SoBanHangViewModel> getSoBanHang(String? maKH, DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement getSoBanHang
    try{
      final response = await _dio.get("/CongNo/so-ban-hang/$maKH", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as Map<String, dynamic>;
      return SoBanHangViewModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<TongHopCongNoModel>> getTongHopCongNo(DateTime ngay) async {
    // TODO: implement getTongHopCongNo
    try{
      final response = await _dio.get("/CongNo/tong-hop", queryParameters: {
        'ngay': DateHelper.yMd(ngay),
      });
      final data = response.data as List;
      return data.map((e)=>TongHopCongNoModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
}