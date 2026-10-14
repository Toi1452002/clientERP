import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:erp_client_1/core/data/network/network_exception.dart';
import 'package:erp_client_1/core/data/network/network_service.dart';
import 'package:erp_client_1/features/report/data/repository/ireport_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final reportRepositoryProvider = Provider<IReportRepository>((ref) {
  final dio = ref.read(networkServiceProvider);
  return ReportRepository(dio);
});

class ReportRepository implements IReportRepository{
  final Dio _dio;

  ReportRepository(this._dio);
  
  
  @override
  Future<Uint8List> pdfPhieuNhap(int id)  async{
    // TODO: implement pdfPhieuNhap
    try{
      final response = await _dio.get("/Report/phieu-nhap/$id", options: Options(
        responseType: ResponseType.bytes
      ));
      final Uint8List pdfBytes = Uint8List.fromList(response.data);
      return pdfBytes;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<Uint8List> pdfPhieuXuat(int id)async {
    // TODO: implement pdfPhieuXuat
    try{
      final response = await _dio.get("/Report/phieu-xuat/$id", options: Options(
          responseType: ResponseType.bytes
      ));
      final Uint8List pdfBytes = Uint8List.fromList(response.data);
      return pdfBytes;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<Uint8List> pdfPhieuThu(int id) async{
    // TODO: implement pdfPhieuThu
    try{
      final response = await _dio.get("/Report/phieu-thu/$id", options: Options(
          responseType: ResponseType.bytes
      ));
      final Uint8List pdfBytes = Uint8List.fromList(response.data);
      return pdfBytes;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }

  @override
  Future<Uint8List> pdfPhieuChi(int id) async {
    // TODO: implement pdfPhieuChi
    try{
      final response = await _dio.get("/Report/phieu-chi/$id", options: Options(
          responseType: ResponseType.bytes
      ));
      final Uint8List pdfBytes = Uint8List.fromList(response.data);
      return pdfBytes;
    }on DioException catch(e){
      throw ApiException.handleDioException(e);
    }catch(e){
      rethrow;
    }
  }
  
  
}