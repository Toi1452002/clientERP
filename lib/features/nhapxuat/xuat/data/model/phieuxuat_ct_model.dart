class PhieuXuatCTModel{
  final int? phieuXuatId;
  final int? hangHoaId;
  final String? tenHH;
  final String? dvt;
  final num? soLg;
  final num? donGia;
  final num? thanhTien;
  final String? tkKho;
  final String? tkgv;

  const PhieuXuatCTModel({
    this.phieuXuatId,
    this.hangHoaId,
    this.tenHH,
    this.dvt,
    this.soLg,
    this.donGia,
    this.thanhTien,
    this.tkKho,
    this.tkgv
  });

  Map<String, dynamic> toMap() {
    return {
      'phieuXuatId': phieuXuatId,
      'hangHoaId': hangHoaId,
      'tenHH': tenHH,
      'dvt': dvt,
      'soLg': soLg,
      'donGia': donGia,
      'thanhTien': thanhTien,
      'tkKho': tkKho,
      'tKgv': tkgv
    };
  }

  factory PhieuXuatCTModel.fromMap(Map<String, dynamic> map) {
    return PhieuXuatCTModel(
      phieuXuatId: map['phieuXuatId'] ,
      hangHoaId: map['hangHoaId'] ,
      tenHH: map['tenHH'] ,
      dvt: map['dvt'] ,
      soLg: map['soLg'] ,
      donGia: map['donGia'] ,
      thanhTien: map['thanhTien'] ,
      tkKho: map['tkKho'] ,
      tkgv: map['tKgv']
    );
  }
}