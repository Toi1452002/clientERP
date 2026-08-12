class PhieuXuatModel{
  final int? id;
  final DateTime? ngay;
  final String phieu;
  final String? maKH;
  final String maNX;
  final String? dienGiai;
  final num? congTien;
  final int? thueSuat;
  final num? tienThue;
  final bool khoa;
  final String createdBy;
  final String? kyHieu;
  final String? soHD;
  final DateTime? ngayCT;
  final String tkNo;
  final String tkCo;
  final String tkVatNo;
  final String tkVatCo;
  final String pttt;

  const PhieuXuatModel({
    this.id,
    this.ngay,
    required this.phieu,
    this.maKH,
    required this.maNX,
    this.dienGiai,
    this.congTien,
    this.thueSuat,
    this.tienThue,
    required this.khoa,
    required this.createdBy,
    this.kyHieu,
    this.soHD,
    this.ngayCT,
    required this.tkNo,
    required this.tkCo,
    required this.tkVatNo,
    required this.tkVatCo,
    required this.pttt,
  });


  factory PhieuXuatModel.fromMap(Map<String, dynamic> map) {
    return PhieuXuatModel(
      id: map['id'] ,
      ngay: DateTime.tryParse(map['ngay']??"") ,
      phieu: map['phieu'] ,
      maKH: map['maKH'] ,
      maNX: map['maNX'] ,
      dienGiai: map['dienGiai'] ,
      congTien: map['congTien'] ,
      thueSuat: map['thueSuat'] ,
      tienThue: map['tienThue'] ,
      khoa: map['khoa'],
      createdBy: map['createdBy'] ,
      kyHieu: map['kyHieu'] ,
      soHD: map['soHD'] ,
      ngayCT: DateTime.tryParse(map['ngayCT']??"") ,
      tkNo: map['tkNo'] ,
      tkCo: map['tkCo'] ,
      tkVatNo: map['tkVatNo'] ,
      tkVatCo: map['tkVatCo'] ,
      pttt: map['pttt'] ,
    );
  }


}