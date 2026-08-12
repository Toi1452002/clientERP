import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_hanghoa_request_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_hanghoa_view_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_khachhang_request_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_khachhang_view_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/model/dky_taikhoan_view_model.dart';
import 'package:erp_client_1/features/danhmuc/dauky/data/repository/idky_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dkyRepositoryProvider = Provider<IDkyRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return DKyRepository(dio);
});

class DKyRepository implements IDkyRepository{
  final Dio _dio;

  DKyRepository(this._dio);

  @override
  Future<List<DKyKhachHangViewModel>> getViewDKyKhachHang() async {
    // TODO: implement getViewDKyKhachHang
    try{
      final response = await _dio.get("/DauKy/kh");
      final data = response.data as List;
      return data.map((e)=>DKyKhachHangViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> updateDKyKhachHang(List<DKyKhachHangRequestModel> data) async{
    // TODO: implement updateDKyKhachHang
    try{
      final response = await _dio.post("/DauKy/kh",data: data.map((e)=>e.toMap()).toList());
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<DKyHangHoaViewModel>> getViewDKyHangHoa() async{
    // TODO: implement getViewDKyHangHoa
    try{
      final response = await _dio.get("/DauKy/hh");
      final data = response.data as List;
      return data.map((e)=>DKyHangHoaViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> updateDkyHangHoa(List<DKyHangHoaRequestModel> data) async {
    // TODO: implement updateDkyHangHoa
    try{
      final response = await _dio.post("/DauKy/hh",data: data.map((e)=>e.toMap()).toList());
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<List<DKyTaiKhoanViewModel>> getViewDKyTaiKhoan() async {
    // TODO: implement getViewDKyTaiKhoan
    try{
      final response = await _dio.get("/DauKy/tk");
      final data = response.data as List;
      return data.map((e)=>DKyTaiKhoanViewModel.fromMap(e)).toList();
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> updateCKCo(num value, String maTK) async {
    // TODO: implement updateDKCo
    try{
      final response = await _dio.patch("/DauKy/ud-ckco/$maTK",queryParameters: {'value': value});
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<int> updateCKNo(num value, String maTK) async {
    // TODO: implement updateDKNo
    try{
      final response = await _dio.patch("/DauKy/ud-ckno/$maTK",queryParameters: {'value': value});
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<bool> updateDKyTaiKhoan(String thang) async {
    // TODO: implement updateDKyTaiKhoan
    try{
      final response = await _dio.post("/DauKy/ghidk",queryParameters: {'thang': thang});
      return response.data;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

}