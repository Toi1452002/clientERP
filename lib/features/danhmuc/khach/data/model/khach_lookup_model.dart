class KhachLookupModel {
  final String maKH;
  final String tenKH;
  final String diaChi;

  const KhachLookupModel({
    required this.maKH,
    required this.tenKH,
    required this.diaChi,
  });

  factory KhachLookupModel.fromMap(Map<String, dynamic> map) {
    return KhachLookupModel(
      maKH: map['maKH'] as String,
      tenKH: map['tenKH'] as String,
      diaChi: map['diaChi'] as String,
    );
  }

}

enum LoaiKH {
  Khach, NhaCung
}