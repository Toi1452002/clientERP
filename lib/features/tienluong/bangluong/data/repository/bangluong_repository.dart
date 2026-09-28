import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_update_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/model/bangluong_view_model.dart';
import 'package:erp_client_1/features/tienluong/bangluong/data/repository/ibangluong_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';

final bangLuongRepositoryProvider = Provider<IBangLuongRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return BangLuongRepository(dio);
});

class BangLuongRepository implements IBangLuongRepository {
  final Dio _dio;

  BangLuongRepository(this._dio);

  @override
  Future<BangLuongViewModel> addRow(int month, int year) async {
    // TODO: implement addRow
    try {
      final response = await _dio.post("/BangLuong", queryParameters: {"month": month, "year": year});
      final data = response.data as Map<String, dynamic>;
      return BangLuongViewModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async {
    // TODO: implement delete
    try {
      final response = await _dio.delete("/BangLuong/$id");
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BangLuongViewModel>> getView(int month, int year) async {
    // TODO: implement getView
    try {
      final response = await _dio.get("/BangLuong", queryParameters: {"month": month, "year": year});
      final data = response.data as List;
      return data.map((e) => BangLuongViewModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BangLuongViewModel> updateCell(BangLuongUpdateModel model, int id, String field) async {
    // TODO: implement updateCell
    try {
      final response = await _dio.put("/BangLuong/$id",data: model.toMap(), queryParameters: {"field": field});
      final data = response.data as Map<String, dynamic>;
      return BangLuongViewModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PCGTViewCTModel>> getPCGT(String maNV, String maPC) async{
    // TODO: implement getPCGT
    try {
      final response = await _dio.get("/PCGT/chi-tiet", queryParameters: {
        "maNV":maNV,
        "maPC": maPC
      });
      final data = response.data as List;
      return data.map((e)=>PCGTViewCTModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }
}
