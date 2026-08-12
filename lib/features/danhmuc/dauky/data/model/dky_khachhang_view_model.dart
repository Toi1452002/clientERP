class DKyKhachHangViewModel{
  final DateTime ngay;
  final String maKH;
  final String? tenKH;
  final num? soDuNo;

  const DKyKhachHangViewModel({
    required this.ngay,
    required this.maKH,
    this.tenKH,
    this.soDuNo,
  });


  factory DKyKhachHangViewModel.fromMap(Map<String, dynamic> map) {
    return DKyKhachHangViewModel(
      ngay: DateTime.parse(map['ngay']),
      maKH: map['maKH'] ,
      tenKH: map['tenKH'] ,
      soDuNo: map['soDuNo'] ,
    );
  }

}