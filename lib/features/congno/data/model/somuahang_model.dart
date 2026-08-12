class SoMuaHangModel{
  final DateTime ngay;
  final String phieu;
  final String? dienGiai;
  final String? dvt;
  final num? soLg;
  final num? donGia;
  final num? tienMua;
  final num? tienTra;
  // final String? maKH;

  const SoMuaHangModel({
    required this.ngay,
    required this.phieu,
    this.dienGiai,
    this.dvt,
    this.soLg,
    this.donGia,
    this.tienMua,
    this.tienTra,
    // this.maKH,
  });


  factory SoMuaHangModel.fromMap(Map<String, dynamic> map) {
    return SoMuaHangModel(
      ngay: DateTime.parse(map['ngay']) ,
      phieu: map['phieu'] ,
      dienGiai: map['dienGiai'] ,
      dvt: map['dvt'] ,
      soLg: map['soLg'] ,
      donGia: map['donGia'] ,
      tienMua: map['tienMua'],
      tienTra: map['tienTra'],
      // maKH: map['maKH'] ,
    );
  }
}