import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/nhatkychung_model.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socaitk_model.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/model/socttk_model.dart';
import 'package:erp_client_1/features/soketoan/nhatky/data/repository/inhatky_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final nhatKyRepositoryProvider = Provider<INhatKyRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return NhatKyRepository(dio);
});

class NhatKyRepository implements INhatKyRepository{
  final Dio _dio;

  NhatKyRepository(this._dio);
  
  
  @override
  Future<List<NhatKyChungModel>> getNhatKyChung(DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement getNhatKyChung
    try{
      final response = await _dio.get("/NhatKy/nhat-ky-chung", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as List;
      return data.map((e)=>NhatKyChungModel.fromMap(e)).toList();

    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SoCaiTKViewModel> getSoCaiTK(String maTK, DateTime tuNgay, DateTime denNgay) async{
    // TODO: implement getSoCaiTK
    try{
      final response = await _dio.get("/NhatKy/so-cai-tai-khoan/$maTK", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as Map<String, dynamic>;
      return SoCaiTKViewModel.fromMap(data);

    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SoCTTKViewModel> getSoCTTK(String maTK, DateTime tuNgay, DateTime denNgay) async{
    // TODO: implement getSoCTTK
    try{
      final response = await _dio.get("/NhatKy/so-chi-tiet-tai-khoan/$maTK", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as Map<String, dynamic>;
      return SoCTTKViewModel.fromMap(data);

    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
}