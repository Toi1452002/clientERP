class TaiKhoanViewModel{
  final int id;
  final String maTK;
  final String tenTK;
  final int maXL;
  final String? ghiChu;
  final String? tinhChat;

  const TaiKhoanViewModel({
    required this.id,
    required this.maTK,
    required this.tenTK,
    required this.maXL,
    this.ghiChu,
    this.tinhChat,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': this.id,
  //     'maTK': this.maTK,
  //     'tenTK': this.tenTK,
  //     'maXL': this.maXL,
  //     'ghiChu': this.ghiChu,
  //     'tinhChat': this.tinhChat,
  //   };
  // }

  factory TaiKhoanViewModel.fromMap(Map<String, dynamic> map) {
    return TaiKhoanViewModel(
      id: map['id'] ,
      maTK: map['maTK'] ,
      tenTK: map['tenTK'] ,
      maXL: map['maXL'] ,
      ghiChu: map['ghiChu'] ,
      tinhChat: map['tinhChat'] ,
    );
  }
}