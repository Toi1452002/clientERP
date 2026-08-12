class BKeHoaDonBanModel{
  final String phieu;
  final String? soHD;
  final String? kyHieu;
  final String? tenKH;
  final String? mst;
  final num congTien;
  final num tienThue;
  final String? dienGiai;
  final DateTime? ngayCT;

  const BKeHoaDonBanModel({
    required this.phieu,
    this.soHD,
    this.kyHieu,
    this.tenKH,
    this.mst,
    required this.congTien,
    required this.tienThue,
    this.dienGiai,
    this.ngayCT,
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'phieu': this.phieu,
  //     'soCT': this.soCT,
  //     'kyHieu': this.kyHieu,
  //     'tenKH': this.tenKH,
  //     'mst': this.mst,
  //     'congTien': this.congTien,
  //     'tienThue': this.tienThue,
  //     'dienGiai': this.dienGiai,
  //     'ngayCT': this.ngayCT,
  //   };
  // }

  factory BKeHoaDonBanModel.fromMap(Map<String, dynamic> map) {
    return BKeHoaDonBanModel(
      phieu: map['phieu'] ,
      soHD: map['soHD'] ,
      kyHieu: map['kyHieu'] ,
      tenKH: map['tenKH'] ,
      mst: map['mst'] ,
      congTien: map['congTien'],
      tienThue: map['tienThue'] ,
      dienGiai: map['dienGiai'] ,
      ngayCT: DateTime.tryParse(map['ngayCT'] ??""),
    );
  }
}