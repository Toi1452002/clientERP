class HangHoaViewModel{
  final int id;
  final String maHH;
  final String tenHH;
  final String? dvt;
  final num giaMua;
  final num giaBan;
  final String? loaiHang;
  final String? nhomHang;
  final String? maNC;

  const HangHoaViewModel({
    required this.id,
    required this.maHH,
    required this.tenHH,
    this.dvt,
    required this.giaMua,
    required this.giaBan,
    this.loaiHang,
    this.nhomHang,
    this.maNC,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': this.id,
  //     'maHH': this.maHH,
  //     'tenHH': this.tenHH,
  //     'dvt': this.dvt,
  //     'giaMua': this.giaMua,
  //     'giaBan': this.giaBan,
  //     'loaiHang': this.loaiHang,
  //     'nhomHang': this.nhomHang,
  //     'maNC': this.maNC,
  //   };
  // }

  factory HangHoaViewModel.fromMap(Map<String, dynamic> map) {
    return HangHoaViewModel(
      id: map['id'] as int,
      maHH: map['maHH'] as String,
      tenHH: map['tenHH'] as String,
      dvt: map['dvt']??'',
      giaMua: map['giaMua'] as num,
      giaBan: map['giaBan'] as num,
      loaiHang: map['loaiHang']??'',
      nhomHang: map['nhomHang']??'',
      maNC: map['maNC']??'',
    );
  }
}