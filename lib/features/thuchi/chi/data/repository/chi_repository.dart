import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/thuchi/chi/data/model/phieuchi_model.dart';
import 'package:erp_client_1/features/thuchi/chi/data/model/phieuchi_save_model.dart';
import 'package:erp_client_1/features/thuchi/chi/data/repository/ichi_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';

final chiRepositoryProvider = Provider<IChiRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return ChiRepository(dio);
});

class ChiRepository implements IChiRepository{
  final Dio _dio;
  ChiRepository(this._dio);

  @override
  Future<PhieuChiModel> add() async {
    // TODO: implement add
    try {
      final response = await _dio.post("/Chi");
      final data = response.data as Map<String, dynamic>;
      return PhieuChiModel.fromMap(data);
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
      final response = await _dio.delete("/Chi/$id");
      final data = response.data ;
      return data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PhieuChiModel?> getFirstPhieu() async {
    // TODO: implement getFirstPhieu
    try {
      final response = await _dio.get("/Chi/first");
      if(response.statusCode == 200){
        final data = response.data as Map<String, dynamic>;
        return PhieuChiModel.fromMap(data);
      }
      return null;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PhieuChiModel?> getLastPhieu() async {
    // TODO: implement getLastPhieu
    try {
      final response = await _dio.get("/Chi/last");
      if(response.statusCode == 200){
        final data = response.data as Map<String, dynamic>;
        return PhieuChiModel.fromMap(data);
      }
      return null;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<PhieuChiModel?> getNext(int id) async {
  //   // TODO: implement getNext
  //   try {
  //     final response = await _dio.get("/Chi/next/$id");
  //     if(response.statusCode == 200){
  //       final data = response.data as Map<String, dynamic>;
  //       return PhieuChiModel.fromMap(data);
  //     }
  //     return null;
  //   } on DioException catch (e) {
  //     throw ApiException.handleDioException(e);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<PhieuChiModel?> getPrevious(int id) async {
  //   // TODO: implement getPrevious
  //   try {
  //     final response = await _dio.get("/Chi/previous/$id");
  //     if(response.statusCode == 200){
  //       final data = response.data as Map<String, dynamic>;
  //       return PhieuChiModel.fromMap(data);
  //     }
  //     return null;
  //   } on DioException catch (e) {
  //     throw ApiException.handleDioException(e);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<int> onSave(PhieuChiSaveModel pc, int id) async {
    // TODO: implement onSave
    try {
      final response = await _dio.put("/Chi/$id", data: pc.toMap());
      final data = response.data;
      return data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> updateEdit(int id) async {
    // TODO: implement updateEdit
    try {
      final response = await _dio.patch("/Chi/$id");
      final data = response.data;
      return data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PhieuChiModel?> getByPhieu(String phieu) async{
    // TODO: implement getByPhieu
    try {
      final response = await _dio.get("/Chi/$phieu");
      if(response.statusCode == 200){
        final data = response.data as Map<String, dynamic>;
        return PhieuChiModel.fromMap(data);
      }
      return null;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PhieuChiModel?> getById(int id) async{
    // TODO: implement getById
    try {
      final response = await _dio.get("/Chi/get-by-id/$id");
      if(response.statusCode == 200){
        final data = response.data as Map<String, dynamic>;
        return PhieuChiModel.fromMap(data);
      }
      return null;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

}