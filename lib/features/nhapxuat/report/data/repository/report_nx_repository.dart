import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hangban_model.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hoadon_ban_model.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/model/bke_hoadon_mua_model.dart';
import 'package:erp_client_1/features/nhapxuat/report/data/repository/ireport_nx_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final reportNXProvider = Provider<IReportNxRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return ReportNxRepository(dio);
});

class ReportNxRepository implements IReportNxRepository {
  final Dio _dio;
  ReportNxRepository(this._dio);
  
  @override
  Future<List<BKeHoaDonBanModel>> getHoaDonBan(DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement getHoaDonBan
    try{
      final response = await _dio.get("/NXReport/hoa-don-ban",queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as List;
      return data.map((e)=>BKeHoaDonBanModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<BKeHoaDonMuaModel>> getHoaDonMua(DateTime tuNgay, DateTime denNgay) async{
    // TODO: implement getHoaDonMua
    try{
      final response = await _dio.get("/NXReport/hoa-don-mua",queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as List;
      return data.map((e)=>BKeHoaDonMuaModel.fromMap(e)).toList();
    }
    on DioException catch(e){
      throw ApiException.handleDioException(e);
    }
    catch(e){
      rethrow;
    }
  }

  @override
  Future<List<BkeHangBanModel>> getHangBan(DateTime tuNgay, DateTime denNgay) async{
    // TODO: implement getHangBan
    try{
      final response = await _dio.get("/NXReport/hang-ban",queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay),
      });
      final data = response.data as List;
      return data.map((e)=>BkeHangBanModel.fromMap(e)).toList();
    }
    on DioException catch(e){
      throw ApiException.handleDioException(e);
    }
    catch(e){
      rethrow;
    }
  }
}