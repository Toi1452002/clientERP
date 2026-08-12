class TongHopCongNoModel{
  final String? maKH;
  final String? tenKH;
  final num? phaiThu;
  final num? phaiTra;

  const TongHopCongNoModel({
    this.maKH,
    this.tenKH,
    this.phaiThu,
    this.phaiTra,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'maKH': this.maKH,
  //     'tenKH': this.tenKH,
  //     'phaiThu': this.phaiThu,
  //     'phaiTra': this.phaiTra,
  //   };
  // }

  factory TongHopCongNoModel.fromMap(Map<String, dynamic> map) {
    return TongHopCongNoModel(
      maKH: map['maKH'] ,
      tenKH: map['tenKH'] ,
      phaiThu: map['phaiThu'] ,
      phaiTra: map['phaiTra'] ,
    );
  }

}