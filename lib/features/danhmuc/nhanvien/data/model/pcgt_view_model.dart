class PCGTViewModel {
  final String maPC;
  final String moTa;
  final num soTieuChuan;

  const PCGTViewModel({required this.maPC, required this.moTa, required this.soTieuChuan});

  factory PCGTViewModel.fromMap(Map<String, dynamic> map) {
    return PCGTViewModel(
      maPC: map['maPC'] as String,
      moTa: map['moTa'] as String,
      soTieuChuan: map['soTieuChuan'] as num,
    );
  }
}

class PCGTRequestModel {
  final String maPC;
  final num soTieuChuan;

  const PCGTRequestModel({required this.maPC, required this.soTieuChuan});

  Map<String, dynamic> toMap() {
    return {'maPC': maPC, 'soTieuChuan': soTieuChuan};
  }
}
