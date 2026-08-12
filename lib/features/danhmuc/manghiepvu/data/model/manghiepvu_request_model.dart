class MaNghiepVuRequestModel{
  final String maNV;
  final String moTa;

  const MaNghiepVuRequestModel({
    required this.maNV,
    required this.moTa,
  });

  Map<String, dynamic> toMap() {
    return {
      'maNV': maNV,
      'moTa': moTa,
    };
  }


}