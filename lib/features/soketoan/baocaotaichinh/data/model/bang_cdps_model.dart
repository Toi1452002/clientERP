class BangCDPSModel{
  final String maTK;
  final String tenTK;
  final num? dkNo;
  final num? dkCo;
  final num? psNo;
  final num? psCo;
  final num? ckNo;
  final num? ckCo;
  final int cap;

  const BangCDPSModel({
    required this.maTK,
    required this.tenTK,
    this.dkNo,
    this.dkCo,
    this.psNo,
    this.psCo,
    this.ckNo,
    this.ckCo,
    required this.cap
  });


  factory BangCDPSModel.fromMap(Map<String, dynamic> map) {
    return BangCDPSModel(
      maTK: map['maTK'] ,
      tenTK: map['tenTK'] ,
      dkNo: map['dkNo'] ,
      dkCo: map['dkCo'] ,
      psNo: map['psNo'] ,
      psCo: map['psCo'] ,
      ckNo: map['ckNo'] ,
      ckCo: map['ckCo'] ,
      cap: map['cap']
    );
  }
}