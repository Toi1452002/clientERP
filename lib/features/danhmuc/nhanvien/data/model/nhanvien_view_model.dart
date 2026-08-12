class NhanVienViewModel{
  final int id;
  final String maNV;
  final String tenNV;
  final bool gioiTinh;
  final DateTime? ngaySinh;
  final String? diaChi;
  final String? trinhDo;
  final String? chuyenMon;

  const NhanVienViewModel({
    required this.id,
    required this.maNV,
    required this.tenNV,
    required this.gioiTinh,
    required this.ngaySinh,
    this.diaChi,
    this.trinhDo,
    this.chuyenMon,
  });


  factory NhanVienViewModel.fromMap(Map<String, dynamic> map) {
    return NhanVienViewModel(
      id: map['id'] as int,
      maNV: map['maNV'] as String,
      tenNV: map['tenNV'] as String,
      gioiTinh: map['gioiTinh'] as bool,
      ngaySinh: DateTime.tryParse(map['ngaySinh']),
      diaChi: map['diaChi'] as String?,
      trinhDo: map['trinhDo'] as String?,
      chuyenMon: map['chuyenMon'] as String?,
    );
  }
}