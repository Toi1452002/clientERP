import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/features/ketchuyen/data/model/buttoan_model.dart';
import 'package:erp_client_1/features/ketchuyen/data/model/ketchuyen_view_model.dart';
import 'package:erp_client_1/features/ketchuyen/data/repository/iketchuyen_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ketChuyenRepositoryProvider = Provider<IKetChuyenRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return KetChuyenRepository(dio);
});

class KetChuyenRepository implements IKetChuyenRepository{
  final Dio _dio;

  KetChuyenRepository(this._dio);

  @override
  Future<List<ButToanModel>> getLookupButToan() async {
    // TODO: implement getLookupButToan
    try{
      final response = await _dio.get("/KetChuyen/but-toan");
      final data = response.data as List;
      return data.map((e)=>ButToanModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<KetChuyenViewModel>> getViewKetChuyen(DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement getViewKetChuyen
    try{
      final response = await _dio.get("/KetChuyen",queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as List;
      return data.map((e)=>KetChuyenViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> add() async {
    // TODO: implement add
    try{
      final response = await _dio.post("/KetChuyen");
      final data = response.data;
      return data;
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    // TODO: implement delete
    try{
      final response = await _dio.delete("/KetChuyen/$id");
      final data = response.data;
      return data;
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> update(KetChuyenViewModel model, int id) async{
    // TODO: implement update
    try{
      final response = await _dio.put("/KetChuyen/$id", data: model.toMap());
      final data = response.data;
      return data;
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<KetChuyenViewModel>> ketChuyenTrinhTu(DateTime tuNgay, DateTime denNgay, String butToan) async{
    // TODO: implement ketChuyenTrinhTu
    try{
      final response = await _dio.get("/KetChuyen/ket-chuyen-trinh-tu/$butToan", queryParameters: {
      'tuNgay': DateHelper.yMd(tuNgay),
      'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as List;
      return data.map((e)=>KetChuyenViewModel.fromMap(e)).toList();
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<KetChuyenViewModel>> ketChuyenTheoThang(DateTime tuNgay, DateTime denNgay) async{
    // TODO: implement ketChuyenTheoThang
    try{
      final response = await _dio.get("/KetChuyen/ket-chuyen-theo-thang", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as List;
      return data.map((e)=>KetChuyenViewModel.fromMap(e)).toList();
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<KetChuyenViewModel>> ketChuyenTheoNam(DateTime tuNgay, DateTime denNgay) async {
    // TODO: implement ketChuyenTheoNam
    try{
      final response = await _dio.get("/KetChuyen/ket-chuyen-theo-nam", queryParameters: {
        'tuNgay': DateHelper.yMd(tuNgay),
        'denNgay': DateHelper.yMd(denNgay)
      });
      final data = response.data as List;
      return data.map((e)=>KetChuyenViewModel.fromMap(e)).toList();
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

}