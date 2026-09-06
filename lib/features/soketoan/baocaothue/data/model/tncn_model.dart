class TNCNModel{
  final int phanCap;
  final String stt;
  final String chiTieu;
  final String maSo;
  final String dvt;
  final num soNamNay;

  const TNCNModel({
    required this.phanCap,
    required this.stt,
    required this.chiTieu,
    required this.maSo,
    required this.dvt,
    required this.soNamNay,
  });

  Map<String, dynamic> toMap() {
    return {
      'phanCap': this.phanCap,
      'stt': this.stt,
      'chiTieu': this.chiTieu,
      'maSo': this.maSo,
      'dvt': this.dvt,
      'soNamNay': this.soNamNay,
    };
  }

  factory TNCNModel.fromMap(Map<String, dynamic> map) {
    return TNCNModel(
      phanCap: map['phanCap'] ,
      stt: map['stt'] ,
      chiTieu: map['chiTieu'] ,
      maSo: map['maSo'] ,
      dvt: map['dvt'] ,
      soNamNay: map['soNamNay'] ,
    );
  }
}