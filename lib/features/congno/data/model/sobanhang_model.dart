class SoBanHangModel{
  final DateTime ngay;
  final String phieu;
  final String? dienGiai;
  final String? dvt;
  final num? soLg;
  final num? donGia;
  final num? tienBan;
  final num? tienTra;

  const SoBanHangModel({
    required this.ngay,
    required this.phieu,
    this.dienGiai,
    this.dvt,
    this.soLg,
    this.donGia,
    this.tienBan,
    this.tienTra,
  });

  factory SoBanHangModel.fromMap(Map<String, dynamic> map) {
    return SoBanHangModel(
      ngay: DateTime.parse(map['ngay']),
      phieu: map['phieu'] ,
      dienGiai: map['dienGiai'] ,
      dvt: map['dvt'] ,
      soLg: map['soLg'] ,
      donGia: map['donGia'] ,
      tienBan: map['tienBan'] ,
      tienTra: map['tienTra'] ,
    );
  }
}