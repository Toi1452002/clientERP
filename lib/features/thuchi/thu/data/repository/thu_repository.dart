import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/thuchi/thu/data/model/phieuthu_model.dart';
import 'package:erp_client_1/features/thuchi/thu/data/model/phieuthu_save_model.dart';
import 'package:erp_client_1/features/thuchi/thu/data/repository/ithu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final thuRepositoryProvider = Provider<IThuRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return ThuRepository(dio);
});

class ThuRepository implements IThuRepository {
  final Dio _dio;

  ThuRepository(this._dio);

  @override
  Future<PhieuThuModel?> getLastPhieu() async {
    // TODO: implement getLastPhieu
    try {
      final response = await _dio.get("/Thu/last");
      if(response.statusCode == 200){
        final data = response.data as Map<String, dynamic>;
        return PhieuThuModel.fromMap(data);
      }
      return null;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> onSave(PhieuThuSaveModel pt, int id) async {
    // TODO: implement onSave
    try {
      final response = await _dio.put("/Thu/$id", data: pt.toMap());
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
      final response = await _dio.patch("/Thu/$id");
      final data = response.data;
      return data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PhieuThuModel> add() async {
    // TODO: implement add
    try {
      final response = await _dio.post("/Thu");
      final data = response.data as Map<String, dynamic>;
      return PhieuThuModel.fromMap(data);
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
      final response = await _dio.delete("/Thu/$id");
      final data = response.data ;
      return data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
    throw UnimplementedError();
  }

  @override
  Future<PhieuThuModel?> getFirstPhieu() async {
    // TODO: implement getFirstPhieu
    try {
      final response = await _dio.get("/Thu/first");
      if(response.statusCode == 200){
        final data = response.data as Map<String, dynamic>;
        return PhieuThuModel.fromMap(data);
      }
      return null;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  // @override
  // Future<PhieuThuModel?> getNext(int id) async {
  //   // TODO: implement getNext
  //   try {
  //     final response = await _dio.get("/Thu/next/$id");
  //     if(response.statusCode == 200){
  //       final data = response.data as Map<String, dynamic>;
  //       return PhieuThuModel.fromMap(data);
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
  // Future<PhieuThuModel?> getPrevious(int id) async{
  //   // TODO: implement getPrevious
  //   try {
  //     final response = await _dio.get("/Thu/previous/$id");
  //     if(response.statusCode == 200){
  //       final data = response.data as Map<String, dynamic>;
  //       return PhieuThuModel.fromMap(data);
  //     }
  //     return null;
  //   } on DioException catch (e) {
  //     throw ApiException.handleDioException(e);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  @override
  Future<PhieuThuModel?> getByPhieu(String phieu) async {
    // TODO: implement getByPhieu
    try {
      final response = await _dio.get("/Thu/$phieu");
      if(response.statusCode == 200){
        final data = response.data as Map<String, dynamic>;
        return PhieuThuModel.fromMap(data);
      }
      return null;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PhieuThuModel?> getById(int id) async{
    // TODO: implement getById
    try {
      final response = await _dio.get("/Thu/get-by-id/$id");
      if(response.statusCode == 200){
        final data = response.data as Map<String, dynamic>;
        return PhieuThuModel.fromMap(data);
      }
      return null;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }
}
