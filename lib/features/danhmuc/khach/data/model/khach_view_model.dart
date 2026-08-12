class KhachViewModel {
  final int id;
  final String maKH;
  final String tenKH;
  final String diaChi;
  final String diDong;
  final String mst;
  final String loaiKH;

  const KhachViewModel({
    required this.id,
    required this.maKH,
    required this.tenKH,
    required this.diaChi,
    required this.diDong,
    required this.mst,
    required this.loaiKH,
  });


  factory KhachViewModel.fromMap(Map<String, dynamic> map) {
    return KhachViewModel(
      id: map['id'] as int,
      maKH: map['maKH'] as String,
      tenKH: map['tenKH'] as String,
      diaChi: map['diaChi'] as String,
      diDong: map['diDong'] as String,
      mst: map['mst'] as String,
      loaiKH: map['loaiKH'] as String,
    );
  }
}