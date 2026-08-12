class HangHoaLookupModel{
  final int id;
  final String maHH;
  final String tenHH;
  final String? dvt;
  final String? tkKho;
  final num giaBan;

  const HangHoaLookupModel({
    required this.id,
    required this.maHH,
    required this.tenHH,
    this.dvt,
    this.tkKho,
    required this.giaBan,
  });
  //
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': this.id,
  //     'maHH': this.maHH,
  //     'tenHH': this.tenHH,
  //     'dvt': this.dvt,
  //     'giaBan': this.giaBan,
  //   };
  // }

  factory HangHoaLookupModel.fromMap(Map<String, dynamic> map) {
    return HangHoaLookupModel(
      id: map['id'] ,
      maHH: map['maHH'] ,
      tenHH: map['tenHH'] ,
      dvt: map['dvt'] ,
      giaBan: map['giaBan'] ,
      tkKho: map['tkKho']
    );
  }

}