class PhieuNhapCTModel{
    final int? phieuNhapId;
    final int? hangHoaId;
    final String? tenHH;
    final String? dvt;
    final num? soLg;
    final num? donGia;
    final num? thanhTien;
    final String? tkKho;

  const PhieuNhapCTModel({
    this.phieuNhapId,
    this.hangHoaId,
    this.tenHH,
    this.dvt,
    this.soLg,
    this.donGia,
    this.thanhTien,
    this.tkKho,
  });

  Map<String, dynamic> toMap() {
    return {
      'phieuNhapId': phieuNhapId,
      'hangHoaId': hangHoaId,
      'tenHH': tenHH,
      'dvt': dvt,
      'soLg': soLg,
      'donGia': donGia,
      'thanhTien': thanhTien,
      'tkKho': tkKho,
    };
  }

  factory PhieuNhapCTModel.fromMap(Map<String, dynamic> map) {
    return PhieuNhapCTModel(
      phieuNhapId: map['phieuNhapId'] ,
      hangHoaId: map['hangHoaId'] ,
      tenHH: map['tenHH'] ,
      dvt: map['dvt'] ,
      soLg: map['soLg'] ,
      donGia: map['donGia'] ,
      thanhTien: map['thanhTien'] ,
      tkKho: map['tkKho'] ,
    );
  }
}