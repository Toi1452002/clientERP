import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/data/model/phieuxuat_request_model.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/data/model/phieuxuat_update_model.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/data/repository/iphieuxuat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/data/network/network_exception.dart';

final phieuXuatRepositoryProvider = Provider<IPhieuXuatRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return PhieuXuatRepository(dio);
});

class PhieuXuatRepository implements IPhieuXuatRepository{
  final Dio _dio;
  PhieuXuatRepository(this._dio);

  @override
  Future<PhieuXuatRequestModel> add() async {
    // TODO: implement add
    try{
      final response = await _dio.post("/Xuat");
      final data = response.data as Map<String, dynamic>;
      return PhieuXuatRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> delete(int id) async {
    // TODO: implement delete
    try{
      await _dio.delete("/Xuat/$id");
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuXuatRequestModel?> getFirst() async {
    // TODO: implement getFirst
    try{
      final response = await _dio.get("/Xuat/first");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuXuatRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuXuatRequestModel?> getLast() async {
    // TODO: implement getLast
    try{
      final response = await _dio.get("/Xuat/last");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuXuatRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuXuatRequestModel?> getNext(int id) async {
    // TODO: implement getNext
    try{
      final response = await _dio.get("/Xuat/next/$id");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuXuatRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuXuatRequestModel?> getPrevious(int id) async {
    // TODO: implement getPrevious
    try{
      final response = await _dio.get("/Xuat/previous/$id");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuXuatRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> update(PhieuXuatUpdateModel x, int id) async {
    // TODO: implement update
    try{
      final response = await _dio.put("/Xuat/$id", data: {
        "phieuXuat": x.phieuXuat.toMap(),
        "phieuXuatCT": x.phieuXuatCT.map((e)=>e.toMap()).toList()

      });
      final data = response.data ;
      return data;
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> updateKhoa(int phieuXuatId) async {
    // TODO: implement updateKhoa
    try{
      final response = await _dio.patch("/Xuat/$phieuXuatId");
      final data = response.data ;
      return data;
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuXuatRequestModel?> getByPhieu(String maPhieu)  async{
    // TODO: implement getByPhieu
    try{
      final response = await _dio.get("/Xuat/$maPhieu");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuXuatRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

}