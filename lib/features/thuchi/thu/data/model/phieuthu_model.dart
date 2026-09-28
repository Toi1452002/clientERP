class PhieuThuModel{
  final int id;
  final DateTime ngay;

  final String phieu;
  final String? maTC;
  final String? maKH;
  final String? tenKH;
  final String? diaChi;
  final String? nguoiNop;
  final String? nguoiThu;
  final String? noiDung;
  // final String? soTK;
  final String? soCT;
  final String? tkNo;
  final String? tkCo;
  final String pttt;
  final num soTien;
  final String? createdBy;
  final bool khoa;
  // final bool isEdit;
  final int stt;
  final int tongStt;
  final int? idTruoc;
  final int? idSau;

  const PhieuThuModel({
    required this.id,
    required this.ngay,
    required this.phieu,
    this.maTC,
    this.maKH,
    this.tenKH,
    this.diaChi,
    this.nguoiNop,
    this.nguoiThu,
    this.noiDung,
    // this.soTK,
    this.soCT,
    this.tkNo,
    this.tkCo,
    required this.pttt,
    required this.soTien,
    this.createdBy,
    this.khoa = false,
    required this.stt,
    required this.tongStt,
    this.idSau,
    this.idTruoc
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'ngay': ngay,
  //     'phieu': phieu,
  //     'maTC': maTC,
  //     'maKH': maKH,
  //     'tenKH': tenKH,
  //     'diaChi': diaChi,
  //     'nguoiNop': nguoiNop,
  //     'nguoiThu': nguoiThu,
  //     'noiDung': noiDung,
  //     // 'soTK': soTK,
  //     'soCT': soCT,
  //     'tkNo': tkNo,
  //     'tkCo': tkCo,
  //     'pttt': pttt,
  //     'soTien': soTien,
  //     'createdBy': createdBy,
  //     'khoa': khoa,
  //   };
  // }

  factory PhieuThuModel.fromMap(Map<String, dynamic> map) {
    return PhieuThuModel(
      id: map['id'] ,
      ngay: DateTime.parse(map['ngay']) ,
      phieu: map['phieu'] ,
      maTC: map['maTC'] ,
      maKH: map['maKH'] ,
      tenKH: map['tenKH'] ,
      diaChi: map['diaChi'] ,
      nguoiNop: map['nguoiNop'] ,
      nguoiThu: map['nguoiThu'] ,
      noiDung: map['noiDung'] ,
      // soTK: map['soTK'] ,
      soCT: map['soCT'] ,
      tkNo: map['tkNo'] ,
      tkCo: map['tkCo'] ,
      pttt: map['pttt'] ,
      soTien: map['soTien'],
      createdBy: map['createdBy'] ,
      khoa:  map['khoa'],
      stt: map['stt'],
      tongStt: map['tongStt'],
      idSau: map['idSau'],
      idTruoc: map['idTruoc']
    );
  }

  // PhieuThuModel copyWith({
  //   int? id,
  //   DateTime? ngay,
  //   String? phieu,
  //   String? maTC,
  //   String? maKH,
  //   String? tenKH,
  //   String? diaChi,
  //   String? nguoiNop,
  //   String? nguoiThu,
  //   String? noiDung,
  //   String? soCT,
  //   String? tkNo,
  //   String? tkCo,
  //   String? pttt,
  //   num? soTien,
  //   String? createdBy,
  //   bool? khoa,
  // }) {
  //   return PhieuThuModel(
  //     id: id ?? this.id,
  //     ngay: ngay ?? this.ngay,
  //     phieu: phieu ?? this.phieu,
  //     maTC: maTC ?? this.maTC,
  //     maKH: maKH ?? this.maKH,
  //     tenKH: tenKH ?? this.tenKH,
  //     diaChi: diaChi ?? this.diaChi,
  //     nguoiNop: nguoiNop ?? this.nguoiNop,
  //     nguoiThu: nguoiThu ?? this.nguoiThu,
  //     noiDung: noiDung ?? this.noiDung,
  //     soCT: soCT ?? this.soCT,
  //     tkNo: tkNo ?? this.tkNo,
  //     tkCo: tkCo ?? this.tkCo,
  //     pttt: pttt ?? this.pttt,
  //     soTien: soTien ?? this.soTien,
  //     createdBy: createdBy ?? this.createdBy,
  //     khoa: khoa ?? this.khoa,
  //   );
  // }

}