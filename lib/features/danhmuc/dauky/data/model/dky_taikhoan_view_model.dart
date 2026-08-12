class DKyTaiKhoanViewModel{
  final String maTK;
  final String tenTK;
  final String? tinhChat;
  final num? dkNo;
  final num? dkCo;

  const DKyTaiKhoanViewModel({
    required this.maTK,
    required this.tenTK,
    required this.tinhChat,
    this.dkNo,
    this.dkCo,
  });


  factory DKyTaiKhoanViewModel.fromMap(Map<String, dynamic> map) {
    return DKyTaiKhoanViewModel(
      maTK: map['maTK'] ,
      tenTK: map['tenTK'] ,
      tinhChat: map['tinhChat'] ,
      dkNo: map['dkNo'],
      dkCo: map['dkCo'],
    );
  }

}