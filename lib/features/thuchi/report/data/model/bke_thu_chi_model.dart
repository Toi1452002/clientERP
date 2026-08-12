class BKeThuChiModel {
  final DateTime? ngay;
  final String phieu;
  final String? maKH;
  final String? tenKH;
  final String pttt;
  final String? noiDung;
  final num soTien;
  final String? tkNo;
  final String? tkCo;
  final String? kieu;

  const BKeThuChiModel({
    this.ngay,
    required this.phieu,
    this.maKH,
    this.tenKH,
    required this.pttt,
    this.noiDung,
    required this.soTien,
    this.tkNo,
    this.tkCo,this.kieu
  });

  factory BKeThuChiModel.fromMap(Map<String, dynamic> map) {
    return BKeThuChiModel(
      ngay: DateTime.tryParse(map['ngay'] ?? ""),
      phieu: map['phieu'],
      maKH: map['maKH'],
      tenKH: map['tenKH'],
      pttt: map['pttt'],
      noiDung: map['noiDung'],
      soTien: map['soTien'],
      tkNo: map['tkNo'],
      tkCo: map['tkCo'],
      kieu: map['kieu'],
    );
  }
}
