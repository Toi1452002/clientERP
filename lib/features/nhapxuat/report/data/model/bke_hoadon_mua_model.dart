class BKeHoaDonMuaModel{
  final String phieu;
  final String? soCT;
  final String? kyHieu;
  final String? tenKH;
  final String? mst;
  final num congTien;
  final num tienThue;
  final String? dienGiai;
  final DateTime? ngayCT;

  const BKeHoaDonMuaModel({
    required this.phieu,
    this.soCT,
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

  factory BKeHoaDonMuaModel.fromMap(Map<String, dynamic> map) {
    return BKeHoaDonMuaModel(
      phieu: map['phieu'] ,
      soCT: map['soCT'] ,
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