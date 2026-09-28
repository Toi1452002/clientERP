import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/danhmuc/dvt/data/model/dvt_model.dart';
import 'package:erp_client_1/features/danhmuc/dvt/data/repository/idvt_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';

final dvtRepositoryProvider = Provider<IDvtRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return DvtRepository(dio);
});

class DvtRepository implements IDvtRepository {
  final Dio _dio;

  DvtRepository(this._dio);

  @override
  Future<List<DvtModel>> getAll() async {
    try {
      final response = await _dio.get("/dvt");
      final data = response.data as List;
      return data.map((e) => DvtModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<DvtModel> add(String dvt) async {
    // TODO: implement add
    try {
     final response =  await _dio.post("/dvt", queryParameters: {'dvt': dvt});
     final data = response.data as Map<String, dynamic>;
     return DvtModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<int> delete(int id) async {
    // TODO: implement delete
    try {
      final response = await _dio.delete("/dvt/$id");
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }

  @override
  Future<DvtModel> update(int id, String dvt) async{
    try {
      final response = await _dio.patch("/dvt/$id",queryParameters: {'dvt': dvt});
      final data = response.data as Map<String, dynamic>;
      return DvtModel.fromMap(data);
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      throw Exception("Unknown error");
    }
  }
}
