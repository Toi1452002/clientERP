class NhapXuatTonModel{
  final String? tenHH;
  final String? nhomHang;
  final String? dvt;
  final num sd;
  final num td;
  final num sn;
  final num tn;
  final num sx;
  final num tx;
  final num gx;
  final num sc;
  final num tc;

  const NhapXuatTonModel({
    this.tenHH,
    this.nhomHang,
    this.dvt,
    required this.sd,
    required this.td,
    required this.sn,
    required this.tn,
    required this.sx,
    required this.tx,
    required this.gx,
    required this.sc,
    required this.tc,
  });


  factory NhapXuatTonModel.fromMap(Map<String, dynamic> map) {
    return NhapXuatTonModel(
      tenHH: map['tenHH'] ,
      nhomHang: map['nhomHang'] ,
      dvt: map['dvt'] ,
      sd: map['sd'] ,
      td: map['td'] ,
      sn: map['sn'] ,
      tn: map['tn'] ,
      sx: map['sx'] ,
      tx: map['tx'] ,
      gx: map['gx'] ,
      sc: map['sc'] ,
      tc: map['tc'] ,
    );
  }

}