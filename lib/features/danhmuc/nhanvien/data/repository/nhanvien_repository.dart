import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_edit_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_lookup_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_request_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_view_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/pcgt_view_model.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/data/repository/inhanvien_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nhanVienRepositoryProvider = Provider<INhanVienRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return NhanVienRepository(dio);
});

class NhanVienRepository implements INhanVienRepository {
  final Dio _dio;

  NhanVienRepository(this._dio);

  @override
  Future<List<NhanVienViewModel>> getView() async {
    // TODO: implement getView
    try {
      final response = await _dio.get("/NhanVien");
      final data = response.data as List;
      return data.map((e) => NhanVienViewModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PCGTViewModel>> getPCGTView(int? nhanVienId) async {
    // TODO: implement getPCGTView
    try {
      final response = nhanVienId == null ? await _dio.get("/PCGT") : await _dio.get("/PCGT/$nhanVienId");
      final data = response.data as List;
      return data.map((e) => PCGTViewModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NhanVienViewModel> add(NhanVienRequestModel nv, List<PCGTRequestModel> lstPC) async {
    // TODO: implement add
    try {
      final response = await _dio.post(
        "/NhanVien",
        data: {'nhanVien': nv.toMap(), 'pcgt': lstPC.map((e) => e.toMap()).toList()},
      );
      final data = response.data as Map<String, dynamic>;
      return NhanVienViewModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NhanVienEditModel> getById(int id) async {
    // TODO: implement getById
    try {
      final response = await _dio.get("/NhanVien/$id");
      final data = response.data as Map<String, dynamic>;
      return NhanVienEditModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<NhanVienViewModel> update(NhanVienRequestModel nv, List<PCGTRequestModel> lstPC, int nhanVienId) async {
    // TODO: implement update
    try {
      final response = await _dio.put(
        "/NhanVien/$nhanVienId",
        data: {'nhanVien': nv.toMap(), 'pcgt': lstPC.map((e) => e.toMap()).toList()},
      );
      final data = response.data as Map<String, dynamic>;
      return NhanVienViewModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> delete(int nhanVienId) async {
    // TODO: implement delete
    try {
      final response = await _dio.delete("/NhanVien/$nhanVienId");
      final data = response.data;
      return data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NhanVienLookupModel>> getLookup() async {
    // TODO: implement getLookup
    try {
      final response = await _dio.get("/NhanVien/lookup");
      final data = response.data as List;
      return data.map((e)=>NhanVienLookupModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }
}
