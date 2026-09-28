class ChuyenLoModel{
  final int id;
  final String namBC;
  final num? loiNhuan;
  final num? soLuyKe;
  final num? nopThue;
  final num? q1;
  final num? q2;
  final num? q3;
  final num? q4;

  const ChuyenLoModel({
    required this.id,
    required this.namBC,
    this.loiNhuan,
    this.soLuyKe,
    this.nopThue,
    this.q1,
    this.q2,
    this.q3,
    this.q4,
  });


  factory ChuyenLoModel.fromMap(Map<String, dynamic> map) {
    return ChuyenLoModel(
      id: map['id'] ,
      namBC: map['namBC'] ,
      loiNhuan: map['loiNhuan'] ,
      soLuyKe: map['soLuyKe'] ,
      nopThue: map['nopThue'] ,
      q1: map['q1'] ,
      q2: map['q2'] ,
      q3: map['q3'] ,
      q4: map['q4'] ,
    );
  }
}