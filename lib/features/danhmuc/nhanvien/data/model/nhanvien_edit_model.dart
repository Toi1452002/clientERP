import 'package:erp_client_1/features/danhmuc/nhanvien/data/model/nhanvien_request_model.dart';

class NhanVienEditModel {
  final int id;
  final String maNV;
  final String tenNV;
  final bool gioiTinh;
  final DateTime? ngaySinh;
  final String? cccd;
  final String? mst;
  final String? diaChi;
  final String? dienThoai;
  final String? trinhDo;
  final String? chuyenMon;
  final DateTime? ngayVao;
  final String? chucDanh;
  final num luongCB;
  final bool thoiVu;
  final bool khongCuTru;
  final bool coCK;
  final String? ghiChu;
  final bool isActive;

  const NhanVienEditModel({
    required this.id,
    required this.maNV,
    required this.tenNV,
    required this.gioiTinh,
    required this.ngaySinh,
    this.cccd,
    this.mst,
    this.diaChi,
    this.dienThoai,
    this.trinhDo,
    this.chuyenMon,
    required this.ngayVao,
    this.chucDanh,
    required this.luongCB,
    required this.thoiVu,
    required this.khongCuTru,
    required this.coCK,
    this.ghiChu,
    required this.isActive,
  });


  factory NhanVienEditModel.fromMap(Map<String, dynamic> map) {
    return NhanVienEditModel(
      id: map['id'] ,
      maNV: map['maNV'] ,
      tenNV: map['tenNV'] ,
      gioiTinh: map['gioiTinh'] ,
      ngaySinh: DateTime.tryParse(map['ngaySinh']??'') ,
      cccd: map['cccd'] ,
      mst: map['mst'] ,
      diaChi: map['diaChi'] ,
      dienThoai: map['dienThoai'] ,
      trinhDo: map['trinhDo'] ,
      chuyenMon: map['chuyenMon'] ,
      ngayVao: DateTime.tryParse(map['ngayVao']??'') ,
      chucDanh: map['chucDanh'] ,
      luongCB: map['luongCB'] ,
      thoiVu: map['thoiVu'] ,
      khongCuTru: map['khongCuTru'] ,
      coCK: map['coCK'] ,
      ghiChu: map['ghiChu'] ,
      isActive: map['isActive'] ,
    );
  }
}
