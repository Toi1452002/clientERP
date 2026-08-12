class KhachEditModel {
  final int id;
  final String maKH;
  final String tenKH;
  final String? diaChi;
  final String? dienThoai;
  final String? diDong;
  final String? fax;
  final String? email;
  final String? mst;
  final String? soTK;
  final String? nganHang;
  final String? ghiChu;
  final String? loaiKH;
  final bool isActive;

  const KhachEditModel({
    required this.id,
    required this.maKH,
    required this.tenKH,
    this.diaChi,
    this.dienThoai,
    this.diDong,
    this.fax,
    this.email,
    this.mst,
    this.soTK,
    this.nganHang,
    this.ghiChu,
    this.loaiKH,
    required this.isActive,
  });


  factory KhachEditModel.fromMap(Map<String, dynamic> map) {
    return KhachEditModel(
      id: map['id'],
      maKH: map['maKH'] as String,
      tenKH: map['tenKH'] as String,
      diaChi: map['diaChi'] as String,
      dienThoai: map['dienThoai'] as String,
      diDong: map['diDong'] as String,
      fax: map['fax'] as String,
      email: map['email'] as String,
      mst: map['mst'] as String,
      soTK: map['soTK'] as String,
      nganHang: map['nganHang'] as String,
      ghiChu: map['ghiChu'] as String,
      loaiKH: map['loaiKH'] as String,
      isActive: map['isActive'] as bool,
    );
  }
}