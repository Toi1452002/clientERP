import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/model/manghiepvu_request_model.dart';
import 'package:erp_client_1/features/danhmuc/manghiepvu/data/repository/imanghiepvu_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final maNghiepVuRepositoryProvider = Provider<IMaNghiepVuRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return MaNghiepVuRepository(dio);
});

class MaNghiepVuRepository implements IMaNghiepVuRepository {
  final Dio _dio;

  MaNghiepVuRepository(this._dio);

  @override
  Future<List<MaNghiepVuModel>> getT() async {
    // TODO: implement getT
    try {
      final response = await _dio.get("/MaNghiepVu/t");
      final data = response.data as List;
      return data.map((e) => MaNghiepVuModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MaNghiepVuModel>> getC() async {
    // TODO: implement getC
    try {
      final response = await _dio.get("/MaNghiepVu/c");
      final data = response.data as List;
      return data.map((e) => MaNghiepVuModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MaNghiepVuModel>> getN() async {
    // TODO: implement getN
    try {
      final response = await _dio.get("/MaNghiepVu/n");
      final data = response.data as List;
      return data.map((e) => MaNghiepVuModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MaNghiepVuModel>> getX() async {
    // TODO: implement getX
    try {
      final response = await _dio.get("/MaNghiepVu/x");
      final data = response.data as List;
      return data.map((e) => MaNghiepVuModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MaNghiepVuModel> add(MaNghiepVuRequestModel model) async {
    // TODO: implement add
    try {
      final response = await _dio.post("/MaNghiepVu", data: model.toMap());
      final data =  response.data as Map<String, dynamic>;
      return MaNghiepVuModel.fromMap(data);
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
      final response = await _dio.delete("/MaNghiepVu/$id");
      return response.data;
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MaNghiepVuModel>> getView() async {
    // TODO: implement getView
    try {
      final response = await _dio.get("/MaNghiepVu");
      final data = response.data as List;
      return data.map((e) => MaNghiepVuModel.fromMap(e)).toList();
    } on DioException catch (e) {
      throw ApiException.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MaNghiepVuModel> update(MaNghiepVuRequestModel model, int id) async {
    // TODO: implement update
    try{
      final response = await _dio.put("/MaNghiepVu/$id", data: model.toMap());
      final data =  response.data as Map<String, dynamic>;
      return MaNghiepVuModel.fromMap(data);
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  // @override
  // Future<int> updateMaNV(String ma, int id) async {
  //   // TODO: implement updateMaNV
  //   try {
  //     final response = await _dio.patch("/MaNghiepVu/ma/$id", queryParameters: {'ma': ma});
  //     return response.data;
  //   } on DioException catch (e) {
  //     throw ApiException.handleDioException(e);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // @override
  // Future<int> updateMoTa(String moTa, int id) async {
  //   // TODO: implement updateMoTa
  //   try {
  //     final response = await _dio.patch("/MaNghiepVu/mo-ta/$id", queryParameters: {'moTa': moTa});
  //     return response.data;
  //   } on DioException catch (e) {
  //     throw ApiException.handleDioException(e);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
