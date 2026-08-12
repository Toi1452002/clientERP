class HangHoaModel{
  final int? id;
  final String maHH;
  final String tenHH;
  final int? dvtId;
  final int? loaiHHId;
  final int? nhomId;
  final num giaMua;
  final num giaBan;
  final String? maNhaCung;
  final String? ghiChu;
  final bool tinhTon;
  final bool isActive;
  final String tkKho;

  const HangHoaModel({
    this.id,
    required this.maHH,
    required this.tenHH,
    this.dvtId,
    this.loaiHHId,
    this.nhomId,
    required this.giaMua,
    required this.giaBan,
    this.maNhaCung,
    this.ghiChu,
    required this.tinhTon,
    required this.isActive,
    required this.tkKho,
  });

  Map<String, dynamic> toMap() {
    return {
      'maHH': maHH,
      'tenHH': tenHH,
      'dvtId': dvtId,
      'loaiHHId': loaiHHId,
      'nhomId': nhomId,
      'giaMua': giaMua,
      'giaBan': giaBan,
      'maNhaCung': maNhaCung,
      'ghiChu': ghiChu,
      'tinhTon': tinhTon,
      'isActive': isActive,
      'tkKho': tkKho,
    };
  }

  factory HangHoaModel.fromMap(Map<String, dynamic> map) {
    return HangHoaModel(
      id: map['id'],
      maHH: map['maHH'] ,
      tenHH: map['tenHH'],
      dvtId: map['dvtId'],
      nhomId: map['nhomId'],
      loaiHHId: map['loaiHHId'],
      giaMua: map['giaMua'],
      giaBan: map['giaBan'],
      maNhaCung: map['maNhaCung'],
      ghiChu: map['ghiChu'],
      tinhTon: map['tinhTon'] ,
      isActive: map['isActive'],
      tkKho: map['tkKho'],
    );
  }
}