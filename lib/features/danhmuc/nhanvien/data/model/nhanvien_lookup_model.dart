class NhanVienLookupModel {
  final int id;
  final String maNV;
  final String tenNV;
  final String? diaChi;

  const NhanVienLookupModel({required this.maNV, required this.tenNV, this.diaChi,required this.id});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': this.id,
  //     'maNV': this.maNV,
  //     'tenNV': this.tenNV,
  //     'diaChi': this.diaChi,
  //   };
  // }

  factory NhanVienLookupModel.fromMap(Map<String, dynamic> map) {
    return NhanVienLookupModel( maNV: map['maNV'], tenNV: map['tenNV'], diaChi: map['diaChi'], id: map['id']);
  }
}
