class TaiKhoanRequestModel {
  final String maTK;
  final String tenTK;
  final int maXL;
  final String? ghiChu;
  final String? tinhChat;
  final String? maLK;

  const TaiKhoanRequestModel({
    required this.maTK,
    required this.tenTK,
    required this.maXL,
    this.ghiChu,
    this.tinhChat,
    this.maLK,
  });

  Map<String, dynamic> toMap() {
    return {
      'maTK': maTK,
      'tenTK': tenTK,
      'maXL': maXL,
      'ghiChu': ghiChu,
      'tinhChat': tinhChat,
      'maLK': maTK.substring(0,2),
    };
  }

  // factory TaiKhoanRequestModel.fromMap(Map<String, dynamic> map) {
  //   return TaiKhoanRequestModel(
  //     maTK: map['maTK'] as String,
  //     tenTK: map['tenTK'] as String,
  //     maXL: map['maXL'] as int,
  //     ghiChu: map['ghiChu'] as String,
  //     tinhChat: map['tinhChat'] as String,
  //     maLK: map['maLK'] as String,
  //   );
  // }
}
