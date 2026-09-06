class TNDNModel{
  final int phanCap;
  final String chiTieu;
  final num? soNamNay;
  final String maSo;

  const TNDNModel({
    required this.phanCap,
    required this.chiTieu,
    this.soNamNay,
    required this.maSo,
  });


  factory TNDNModel.fromMap(Map<String, dynamic> map) {
    return TNDNModel(
      phanCap: map['phanCap'],
      chiTieu: map['chiTieu'] ,
      soNamNay: map['soNamNay'] ,
      maSo: map['maSo'],
    );
  }

}