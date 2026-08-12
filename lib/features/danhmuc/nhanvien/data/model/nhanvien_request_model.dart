import 'package:erp_client_1/core/utils/date_helper.dart';

class NhanVienRequestModel{
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

  const NhanVienRequestModel({
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

  Map<String, dynamic> toMap() {
    return {
      'maNV': maNV,
      'tenNV': tenNV,
      'gioiTinh': gioiTinh,
      'ngaySinh': DateHelper.yMd(ngaySinh),
      'cccd': cccd,
      'mst': mst,
      'diaChi': diaChi,
      'dienThoai': dienThoai,
      'trinhDo': trinhDo,
      'chuyenMon': chuyenMon,
      'ngayVao': DateHelper.yMd(ngayVao),
      'chucDanh': chucDanh,
      'luongCB': luongCB,
      'thoiVu': thoiVu,
      'khongCuTru': khongCuTru,
      'coCK': coCK,
      'ghiChu': ghiChu,
      'isActive': isActive,
    };
  }

  // factory NhanVienResponseModel.fromMap(Map<String, dynamic> map) {
  //   return NhanVienResponseModel(
  //     maNV: map['maNV'] as String,
  //     tenNV: map['tenNV'] as String,
  //     gioiTinh: map['gioiTinh'] as bool,
  //     ngaySinh: map['ngaySinh'] as DateTime,
  //     cccd: map['cccd'] as String,
  //     mst: map['mst'] as String,
  //     diaChi: map['diaChi'] as String,
  //     dienThoai: map['dienThoai'] as String,
  //     trinhDo: map['trinhDo'] as String,
  //     chuyenMon: map['chuyenMon'] as String,
  //     ngayVao: map['ngayVao'] as DateTime,
  //     chucDanh: map['chucDanh'] as String,
  //     luongCB: map['luongCB'] as num,
  //     thoiVu: map['thoiVu'] as bool,
  //     khongCuTru: map['khongCuTru'] as bool,
  //     coCK: map['coCK'] as bool,
  //     ghiChu: map['ghiChu'] as String,
  //     isActive: map['isActive'] as bool,
  //   );
  // }
}