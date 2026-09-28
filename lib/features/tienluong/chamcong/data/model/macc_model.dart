class MaCCModel{
  final String ma;
  final num soCong;

  const MaCCModel({
    required this.ma,
    required this.soCong,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'ma': this.ma,
  //     'soCong': this.soCong,
  //   };
  // }

  factory MaCCModel.fromMap(Map<String, dynamic> map) {
    return MaCCModel(
      ma: map['ma'] ,
      soCong: map['soCong'],
    );
  }

}