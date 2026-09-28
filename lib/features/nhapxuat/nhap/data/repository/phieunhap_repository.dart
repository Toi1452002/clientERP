import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhap_response_model.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/model/phieunhap_update_model.dart';
import 'package:erp_client_1/features/nhapxuat/nhap/data/repository/iphieunhap_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final phieuNhapRepositoryProvider = Provider<IPhieuNhapRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return PhieuNhapRepository(dio);
});

class PhieuNhapRepository implements IPhieuNhapRepository{
  final Dio _dio;
  const PhieuNhapRepository(this._dio);
  
  @override
  Future<PhieuNhapRequestModel> add() async {
    // TODO: implement add
    try{
      final response = await _dio.post("/Nhap");
      final data = response.data as Map<String, dynamic>;
      return PhieuNhapRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuNhapRequestModel?> getLast() async {
    // TODO: implement getLast
    try{
      final response = await _dio.get("/Nhap/last");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuNhapRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> update(PhieuNhapUpdateModel x, int id) async {
    // TODO: implement update
    try{
      final response = await _dio.put("/Nhap/$id", data: {
        "phieuNhap": x.phieuNhap.toMap(),
        "phieuNhapCT": x.phieuNhapCT.map((e)=>e.toMap()).toList()

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
  Future<void> updateKhoa(int phieuNhapId) async{
    // TODO: implement updateKhoa
    try{
      final response = await _dio.patch("/Nhap/$phieuNhapId");
      final data = response.data ;
      return data;
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuNhapRequestModel?> getFirst() async{
    // TODO: implement getFirst
    try{
      final response = await _dio.get("/Nhap/first");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuNhapRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  // @override
  // Future<PhieuNhapRequestModel?> getNext(int id) async{
  //   // TODO: implement getNext
  //   try{
  //     final response = await _dio.get("/Nhap/next/$id");
  //     if(response.statusCode == 204){
  //       return null;
  //     }
  //     final data = response.data as Map<String, dynamic>;
  //     return PhieuNhapRequestModel.fromMap(data);
  //   }on  DioException catch(e){
  //     throw ApiException.handleDioException(e);
  //   }catch(e){
  //     rethrow;
  //   }
  // }

  // @override
  // Future<PhieuNhapRequestModel?> getPrevious(int id) async{
  //   // TODO: implement getPrevious
  //   try{
  //     final response = await _dio.get("/Nhap/previous/$id");
  //     if(response.statusCode == 204){
  //       return null;
  //     }
  //     final data = response.data as Map<String, dynamic>;
  //     return PhieuNhapRequestModel.fromMap(data);
  //   }on  DioException catch(e){
  //     throw ApiException.handleDioException(e);
  //   }catch(e){
  //     rethrow;
  //   }
  // }

  @override
  Future<void> delete(int id) async {
    // TODO: implement delete
    try{
      await _dio.delete("/Nhap/$id");
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuNhapRequestModel?> getByPhieu(String maPhieu) async {
    // TODO: implement getByPhieu
    try{
      final response = await _dio.get("/Nhap/$maPhieu");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuNhapRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<PhieuNhapRequestModel?> getById(int id) async {
    // TODO: implement getById
    try{
      final response = await _dio.get("/Nhap/get-by-id/$id");
      if(response.statusCode == 204){
        return null;
      }
      final data = response.data as Map<String, dynamic>;
      return PhieuNhapRequestModel.fromMap(data);
    }on  DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
}