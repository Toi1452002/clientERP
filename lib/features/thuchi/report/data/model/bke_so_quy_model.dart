class BKeSoQuyModel{
  final String ngay;
  final String phieu;
  final String? dienGiai;
  final String? kieu;
  final String pttt;
  final String? chungTu;
  final String? tkDU;
  final num? thu;
  final num? chi;

  const BKeSoQuyModel({
    required this.ngay,
    required this.phieu,
    this.dienGiai,
     this.kieu,
    required this.pttt,
    this.chungTu,
    this.tkDU,
    this.thu,
    this.chi,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'ngay': this.ngay,
  //     'phieu': this.phieu,
  //     'dienGiai': this.dienGiai,
  //     'kieu': this.kieu,
  //     'pttt': this.pttt,
  //     'chungTu': this.chungTu,
  //     'tkDU': this.tkDU,
  //     'thu': this.thu,
  //     'chi': this.chi,
  //   };
  // }

  factory BKeSoQuyModel.fromMap(Map<String, dynamic> map) {
    return BKeSoQuyModel(
      ngay: map['ngay'] ,
      phieu: map['phieu'] ,
      dienGiai: map['dienGiai'] ,
      kieu: map['kieu'] ,
      pttt: map['pttt'] ,
      chungTu: map['chungTu'] ,
      tkDU: map['tkDU'] ,
      thu: map['thu'] ,
      chi: map['chi'] ,
    );
  }
}