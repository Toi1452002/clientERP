import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/thuchi/report/data/model/bke_so_quy_model.dart';
import 'package:erp_client_1/features/thuchi/report/data/model/bke_thu_chi_model.dart';
import 'package:erp_client_1/features/thuchi/report/data/model/soquy_request_model.dart';
import 'package:erp_client_1/features/thuchi/report/data/repository/itc_report_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final tcReportProvider = Provider<ITCReportRepository>((ref){
  final dio = ref.read(networkServiceProvider);
  return TcReportRepository(dio);
});


class TcReportRepository implements ITCReportRepository {
  final Dio _dio;

  TcReportRepository(this._dio);

  @override
  Future<List<BKeThuChiModel>> getBkePhieuChi(DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement getBkePhieuChi
    try{
      final response = await _dio.get("/TCReport/chi",queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as List;
      return data.map((e)=>BKeThuChiModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<BKeThuChiModel>> getBkePhieuThu(DateTime tuNgay, DateTime denNgay) async{
    // TODO: implement getBkePhieuThu
    try{
      final response = await _dio.get("/TCReport/thu",queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as List;
      return data.map((e)=>BKeThuChiModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SoQuyRequestModel> getBkeSoQuyTG(DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement getBkeSoQuyTG
    try{
      final response = await _dio.get("/TCReport/so-quy-tg",queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as Map<String, dynamic>;
      return SoQuyRequestModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<SoQuyRequestModel> getBkeSoQuyTM(DateTime tuNgay, DateTime denNgay) async{
    // TODO: implement getBkeSoQuyTM
    try{
      final response = await _dio.get("/TCReport/so-quy-tm",queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as Map<String, dynamic>;
      return SoQuyRequestModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
}
