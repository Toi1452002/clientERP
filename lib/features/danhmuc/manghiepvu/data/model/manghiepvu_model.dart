class MaNghiepVuModel{
  final int id;
  final String maNV;
  final String moTa;

  const MaNghiepVuModel({
    required this.id,
    required this.maNV,
    required this.moTa,
  });


  factory MaNghiepVuModel.fromMap(Map<String, dynamic> map) {
    return MaNghiepVuModel(
      id: map['id'] as int,
      maNV: map['maNV'] as String,
      moTa: map['moTa'] as String,
    );
  }

}

enum KieuNghiepVu {
  thu, chi, nhap, xuat
}