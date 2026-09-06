class BangTmpModel{
  final int phanCap;
  final String chiTieu;
  final String maSo;
  final String? thuyetMinh;
  final num? soNamNay;
  final num? soNamTruoc;

  const BangTmpModel({
    required this.phanCap,
    required this.chiTieu,
    required this.maSo,
    this.thuyetMinh,
    this.soNamNay,
    this.soNamTruoc,
  });

  Map<String, dynamic> toMap() {
    return {
      'phanCap': this.phanCap,
      'chiTieu': this.chiTieu,
      'maSo': this.maSo,
      'thuyetMinh': this.thuyetMinh,
      'soNamNay': this.soNamNay,
      'soNamTruoc': this.soNamTruoc,
    };
  }

  factory BangTmpModel.fromMap(Map<String, dynamic> map) {
    return BangTmpModel(
      phanCap: map['phanCap'] ,
      chiTieu: map['chiTieu'] ,
      maSo: map['maSo'] ,
      thuyetMinh: map['thuyetMinh'] ,
      soNamNay: map['soNamNay'] ,
      soNamTruoc: map['soNamTruoc'] ,
    );
  }
}