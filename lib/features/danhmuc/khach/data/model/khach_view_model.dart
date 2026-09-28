class KhachViewModel {
  final int id;
  final String maKH;
  final String tenKH;
  final String? diaChi;
  final String? diDong;
  final String? mst;
  final String loaiKH;
  final bool isActive;

  const KhachViewModel({
    required this.id,
    required this.maKH,
    required this.tenKH,
    required this.diaChi,
    required this.diDong,
    required this.mst,
    required this.loaiKH,
    required this.isActive
  });


  factory KhachViewModel.fromMap(Map<String, dynamic> map) {
    return KhachViewModel(
      id: map['id'] ,
      maKH: map['maKH'] ,
      tenKH: map['tenKH'] ,
      diaChi: map['diaChi'] ,
      diDong: map['diDong'] ,
      mst: map['mst'] ,
      loaiKH: map['loaiKH'] ,
      isActive: map['isActive']
    );
  }
}