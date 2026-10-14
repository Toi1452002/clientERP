class KhachLookupModel {
  final String maKH;
  final String tenKH;
  final String diaChi;
  final int id;

  const KhachLookupModel({
    required this.maKH,
    required this.tenKH,
    required this.diaChi,
    required this.id
  });

  factory KhachLookupModel.fromMap(Map<String, dynamic> map) {
    return KhachLookupModel(
      maKH: map['maKH'] as String,
      tenKH: map['tenKH'] as String,
      diaChi: map['diaChi'] as String,
      id: map['id']
    );
  }

}

enum LoaiKH {
  Khach, NhaCung
}