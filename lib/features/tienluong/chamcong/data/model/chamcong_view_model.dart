class ChamCongViewModel {
  final int id;
  final String? maNV;
  final String? tenNV;
  final num? tongCong;
  final Map<int, ChamCongCTModel> ngay;

  const ChamCongViewModel({required this.id, this.maNV, this.tenNV, this.tongCong, required this.ngay});

  factory ChamCongViewModel.fromJson(Map<String, dynamic> json) {
    final ngayJson = json['ngay'] as Map<String, dynamic>? ?? {};

    return ChamCongViewModel(
      id: json['id'],
      maNV: json['maNV'],
      tenNV: json['tenNV'],
      tongCong: json['tongCong'],

      ngay: ngayJson.map(
        (key, value) => MapEntry(int.parse(key), ChamCongCTModel.fromMap(value as Map<String, dynamic>)),
      ),
    );
  }
}

class ChamCongCTModel {
  final String? kyHieu;


  const ChamCongCTModel({this.kyHieu});

  factory ChamCongCTModel.fromMap(Map<String, dynamic> map) {
    return ChamCongCTModel(kyHieu: map['kyHieu']);
  }
}
