class ChuyenLoCTModel{
  final int id;
  final String namPSLo;
  final num? soLoPS;
  final num? loDaChuyenKyTruoc;
  final num? loDuocChuyenKyNay;
  final num? loDuocChuyenKySau;
  final bool? conLo;

  const ChuyenLoCTModel({
    required this.id,
    required this.namPSLo,
    this.soLoPS,
    this.loDaChuyenKyTruoc,
    this.loDuocChuyenKyNay,
    this.loDuocChuyenKySau,
    this.conLo,
  });

  Map<String, dynamic> toMap() {
    return {
      'loDaChuyenKyTruoc': loDaChuyenKyTruoc,
      'loDuocChuyenKyNay': loDuocChuyenKyNay,
      'loDuocChuyenKySau': loDuocChuyenKySau,
      'conLo': conLo,
    };
  }

  factory ChuyenLoCTModel.fromMap(Map<String, dynamic> map) {
    return ChuyenLoCTModel(
      id: map['id'] ,
      namPSLo: map['namPSLo'] ,
      soLoPS: map['soLoPS'] ,
      loDaChuyenKyTruoc: map['loDaChuyenKyTruoc'] ,
      loDuocChuyenKyNay: map['loDuocChuyenKyNay'] ,
      loDuocChuyenKySau: map['loDuocChuyenKySau'] ,
      conLo: map['conLo'] ,
    );
  }
}