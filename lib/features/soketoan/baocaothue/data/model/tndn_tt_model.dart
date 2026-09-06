class TNDNttModel{
  final String chiTieu;
  final num? soNamNay;
  final int phanCap;

  const TNDNttModel({
    required this.chiTieu,
    this.soNamNay,
    required this.phanCap,
  });


  factory TNDNttModel.fromMap(Map<String, dynamic> map) {
    return TNDNttModel(
      chiTieu: map['chiTieu'] ,
      soNamNay: map['soNamNay'],
      phanCap: map['phanCap'],
    );
  }

}