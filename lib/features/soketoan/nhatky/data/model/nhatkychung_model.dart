class NhatKyChungModel{
  final DateTime ngay;
  final DateTime ngayCT;
  final String? chungTu;
  final String? dienGiai;
  final String? tkNo;
  final String? tkCo;
  final num? soPS;

  const NhatKyChungModel({
    required this.ngay,
    required this.ngayCT,
    required this.chungTu,
    this.dienGiai,
    this.tkNo,
    this.tkCo,
    this.soPS,
  });

  factory NhatKyChungModel.fromMap(Map<String, dynamic> map) {
    return NhatKyChungModel(
      ngay: DateTime.parse(map['ngay']),
      ngayCT: DateTime.parse(map['ngayCT']) ,
      chungTu: map['chungTu'] ,
      dienGiai: map['dienGiai'] ,
      tkNo: map['tkNo'] ,
      tkCo: map['tkCo'] ,
      soPS: map['soPS'] ,
    );
  }
}