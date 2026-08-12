class BkeHangBanModel {
  final String maHH;
  final String tenHH;
  final String? dvt;
  final num soLg;
  final num thanhTien;
  final int thueSuat;
  final num tienThue;
  final num congTien;

  const BkeHangBanModel({
    required this.maHH,
    required this.tenHH,
    this.dvt,
    required this.soLg,
    required this.thanhTien,
    required this.thueSuat,
    required this.tienThue,
    required this.congTien,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'maHH': this.maHH,
  //     'tenHH': this.tenHH,
  //     'dvt': this.dvt,
  //     'soLg': this.soLg,
  //     'thanhTien': this.thanhTien,
  //     'thueSuat': this.thueSuat,
  //     'tienThue': this.tienThue,
  //     'congTien': this.congTien,
  //   };
  // }

  factory BkeHangBanModel.fromMap(Map<String, dynamic> map) {
    return BkeHangBanModel(
      maHH: map['maHH'] ,
      tenHH: map['tenHH'] ,
      dvt: map['dvt'] ,
      soLg: map['soLg'] ,
      thanhTien: map['thanhTien'] ,
      thueSuat: map['thueSuat'],
      tienThue: map['tienThue'] ,
      congTien: map['congTien'] ,
    );
  }
}