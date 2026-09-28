class BangLuongViewModel{
  final int id;
  final String? maNV;
  final String? tenNV;
  final String? chucVu;
  final num? ngayCong;
  final num? luongCoBan;
  final num? luongThoiGian;
  final num? pc1;
  final num? pc2;
  final num? luongBHXH;
  final num? bh;
  final num? tNchiuthue;
  final num? gt;
  final num? tNtinhthue;
  final num? thueCN;
  final num? tamUng;
  final num? thucLanh;
  final num? conLai;
  final num? tongThuNhap;

  const BangLuongViewModel({
    required this.id,
    this.maNV,
    this.tenNV,
    this.chucVu,
    this.ngayCong,
    this.luongCoBan,
    this.luongThoiGian,
    this.pc1,
    this.pc2,
    this.luongBHXH,
    this.bh,
    this.tNchiuthue,
    this.gt,
    this.tNtinhthue,
    this.thueCN,
    this.tamUng,
    this.thucLanh,
    this.conLai,
    this.tongThuNhap,
  });


  factory BangLuongViewModel.fromMap(Map<String, dynamic> map) {
    return BangLuongViewModel(
      id: map['id'] ,
      maNV: map['maNV'] ,
      tenNV: map['tenNV'] ,
      chucVu: map['chucVu'] ,
      ngayCong: map['ngayCong'] ,
      luongCoBan: map['luongCoBan'] ,
      luongThoiGian: map['luongThoiGian'] ,
      pc1: map['pC1'] ,
      pc2: map['pC2'] ,
      luongBHXH: map['luongBHXH'] ,
      bh: map['bh'] ,
      tNchiuthue: map['tNchiuthue'] ,
      gt: map['gt'] ,
      tNtinhthue: map['tNtinhthue'] ,
      thueCN: map['thueCN'] ,
      tamUng: map['tamUng'] ,
      thucLanh: map['thucLanh'] ,
      conLai: map['conLai'] ,
      tongThuNhap: map['tongThuNhap'] ,
    );
  }
}