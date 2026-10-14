import 'dart:typed_data';

abstract interface class IReportRepository{
  Future<Uint8List> pdfPhieuNhap(int id);
  Future<Uint8List> pdfPhieuXuat(int id);
  Future<Uint8List> pdfPhieuThu(int id);
  Future<Uint8List> pdfPhieuChi(int id);
}