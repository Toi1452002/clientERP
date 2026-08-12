class BKeNhapXuatModel{
  final DateTime ngay;
  final String phieu;
  final String? maNX;
  final String? maKH;
  final String? maHH;
  final String? tenHH;
  final String? dvt;
  final num? soLg;
  final num? donGia;
  final num? thanhTien;

  const BKeNhapXuatModel({
    required this.ngay,
    required this.phieu,
    this.maNX,
    this.maKH,
    this.maHH,
    this.tenHH,
    this.dvt,
    this.soLg,
    this.donGia,
    this.thanhTien,
  });


  factory BKeNhapXuatModel.fromMap(Map<String, dynamic> map) {
    return BKeNhapXuatModel(
      ngay: DateTime.parse(map['ngay']) ,
      phieu: map['phieu'] ,
      maNX: map['maNX'] ,
      maKH: map['maKH'] ,
      maHH: map['maHH'] ,
      tenHH: map['tenHH'] ,
      dvt: map['dvt'] ,
      soLg: map['soLg'] ,
      donGia: map['donGia'] ,
      thanhTien: map['thanhTien'] ,
    );
  }
}