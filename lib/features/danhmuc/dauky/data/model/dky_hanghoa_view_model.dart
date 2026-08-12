class DKyHangHoaViewModel{
  final int id;
  final String maHH;
  final String? tenHH;
  final DateTime ngay;
  final num? soTon;
  final num? giaVon;

  const DKyHangHoaViewModel({
    required this.id,
    required this.maHH,
    this.tenHH,
    required this.ngay,
    required this.soTon,
    required this.giaVon,
  });


  factory DKyHangHoaViewModel.fromMap(Map<String, dynamic> map) {
    return DKyHangHoaViewModel(
      id: map['id'] ,
      maHH: map['maHH'] ,
      tenHH: map['tenHH'] ,
      ngay: DateTime.parse(map['ngay']) ,
      soTon: map['soTon'] ,
      giaVon: map['giaVon'] ,
    );
  }
}