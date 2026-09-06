class TaiKhoanLookupModel{
  final String maTK;
  final String tenTK;

  const TaiKhoanLookupModel({
    required this.maTK,
    required this.tenTK,
  });


  factory TaiKhoanLookupModel.fromMap(Map<String, dynamic> map) {
    return TaiKhoanLookupModel(
      maTK: map['maTK'] as String,
      tenTK: map['tenTK'] as String,
    );
  }
}

enum LoaiTaiKhoan{
  khoND, maXL0, tkNoPx, tkCoPx, soCai
}