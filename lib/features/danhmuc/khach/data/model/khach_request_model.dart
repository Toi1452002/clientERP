class KhachRequestModel {
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

  const KhachRequestModel({
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
    this.isActive = true,
  });


  Map<String, dynamic> toMap() {
    return {
      'maKH': maKH,
      'tenKH': tenKH,
      'diaChi': diaChi,
      'dienThoai': dienThoai,
      'diDong': diDong,
      'fax': fax,
      'email': email,
      'mst': mst,
      'soTK': soTK,
      'nganHang': nganHang,
      'ghiChu': ghiChu,
      'loaiKH': loaiKH,
      'isActive': isActive,
    };
  }
}