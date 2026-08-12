class LoaiHangModel{
  final int id;
  final String loaiHang;

  const LoaiHangModel({
    required this.id,
    required this.loaiHang,
  });

  factory LoaiHangModel.fromMap(Map<String, dynamic> map) {
    return LoaiHangModel(
      id: map['id'] as int,
      loaiHang: map['loaiHang'] as String,
    );
  }

}