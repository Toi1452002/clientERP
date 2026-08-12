import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/kho/data/model/bke_nhapxuat_model.dart';
import 'package:erp_client_1/features/kho/data/model/nhapxuatton_model.dart';
import 'package:erp_client_1/features/kho/data/repository/ikhohang_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final khoHangRepositoryProvider = Provider<IKhoHangRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return KhoHangRepository(dio);
});

class KhoHangRepository implements IKhoHangRepository {
  final Dio _dio;

  KhoHangRepository(this._dio);

  @override
  Future<List<BKeNhapXuatModel>> getBKeHangNhap(DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement getBKeHangNhap
    try{
      final response = await _dio.get("/KhoHang/hang-nhap", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as List;
      return data.map((e)=>BKeNhapXuatModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<BKeNhapXuatModel>> getBKeHangXuat(DateTime tuNgay, DateTime denNgay) async{
    // TODO: implement getBKeHangXuat
    try{
      final response = await _dio.get("/KhoHang/hang-xuat", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as List;
      return data.map((e)=>BKeNhapXuatModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<NhapXuatTonModel>> getNhapXuatTon(DateTime tuNgay, DateTime denNgay, String maTK) async {
    // TODO: implement getNhapXuatTon
    try{
      final response = await _dio.get("/KhoHang/ton-kho/$maTK", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as List;
      return data.map((e)=>NhapXuatTonModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
}
