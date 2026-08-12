class NhomHangModel{
  final int id;
  final String nhomHang;

  const NhomHangModel({
    required this.id,
    required this.nhomHang,
  });


  factory NhomHangModel.fromMap(Map<String, dynamic> map) {
    return NhomHangModel(
      id: map['id'] as int,
      nhomHang: map['nhomHang'] as String,
    );
  }

  NhomHangModel copyWith({
    int? id,
    String? nhomHang,
  }) {
    return NhomHangModel(
      id: id ?? this.id,
      nhomHang: nhomHang ?? this.nhomHang,
    );
  }

}