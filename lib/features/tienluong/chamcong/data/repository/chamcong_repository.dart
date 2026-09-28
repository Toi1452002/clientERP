import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/chamcong_view_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/macc_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/model/update_socong_model.dart';
import 'package:erp_client_1/features/tienluong/chamcong/data/repository/ichamcong_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chamCongRepositoryProvider = Provider<IChamCongRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return ChamCongRepository(dio);
});

class ChamCongRepository implements IChamCongRepository{
  final Dio _dio;

  ChamCongRepository(this._dio);


  @override
  Future<List<ChamCongViewModel>> getView(int month, int year) async {
    // TODO: implement getView
    try{
      final response = await _dio.get("/ChamCong",queryParameters: {
        'month': month,
        'year': year
      });
      final data = response.data as List;
      return data.map((e)=>ChamCongViewModel.fromJson(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<MaCCModel>> getListMaCC()  async{
    // TODO: implement getListMaCC
    try{
      final response = await _dio.get("/ChamCong/ma-cc");
      final data = response.data as List;
      return data.map((e)=>MaCCModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<num> updateSoCong(UpdateSoCongModel model) async{
    // TODO: implement updateSoCong
    try{
      final response = await _dio.put("/ChamCong/update-so-cong", data: model.toMap());
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> addRow(int month, int year)  async{
    // TODO: implement addRow
    try{
      final response = await _dio.post("/ChamCong", queryParameters: {
        'month': month,
        'year': year
      });
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> delete(int id) async{
    // TODO: implement delete
    try{
      final response = await _dio.delete("/ChamCong/$id");
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<void> updateMaNV(String maNV, int id) async{
    // TODO: implement updateMaNV
    try{
       await _dio.patch("/ChamCong/$id", queryParameters: {
        'maNV': maNV
      });
      // return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

}