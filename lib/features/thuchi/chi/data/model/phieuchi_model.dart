class PhieuChiModel{
  final int id;
  final DateTime ngay;
  final String phieu;
  final String? maTC;
  final String? maKH;
  final String? maNV;
  final String? tenKH;
  final String? diaChi;
  final String? nguoiChi;
  final String? nguoiNhan;
  final String? noiDung;
  final String? soCT;
  final String? tkNo;
  final String? tkCo;
  final String pttt;
  final num soTien;
  final String? createdBy;
  final bool khoa;
  final int stt;
  final int tongStt;
  final int? idTruoc;
  final int? idSau;
  const PhieuChiModel({
    required this.id,
    required this.ngay,
    required this.phieu,
    this.maTC,
    this.maKH,
    this.maNV,
    this.tenKH,
    this.diaChi,
    this.nguoiChi,
    this.nguoiNhan,
    this.noiDung,
    this.soCT,
    this.tkNo,
    this.tkCo,
    required this.pttt,
    required this.soTien,
    this.createdBy,
    required this.khoa,
    required this.stt,
    required this.tongStt,
    this.idSau,
    this.idTruoc
  });

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': this.id,
  //     'ngay': this.ngay,
  //     'phieu': this.phieu,
  //     'maTC': this.maTC,
  //     'maKH': this.maKH,
  //     'maNV': this.maNV,
  //     'tenKH': this.tenKH,
  //     'diaChi': this.diaChi,
  //     'nguoiChi': this.nguoiChi,
  //     'nguoiNhan': this.nguoiNhan,
  //     'noiDung': this.noiDung,
  //     'soCT': this.soCT,
  //     'tkNo': this.tkNo,
  //     'tkCo': this.tkCo,
  //     'pttt': this.pttt,
  //     'soTien': this.soTien,
  //     'createdBy': this.createdBy,
  //     'khoa': this.khoa,
  //   };
  // }

  factory PhieuChiModel.fromMap(Map<String, dynamic> map) {
    return PhieuChiModel(
      id: map['id'] ,
      ngay: DateTime.parse(map['ngay']) ,
      phieu: map['phieu'] ,
      maTC: map['maTC'] ,
      maKH: map['maKH'] ,
      maNV: map['maNV'] ,
      tenKH: map['tenKH'] ,
      diaChi: map['diaChi'] ,
      nguoiChi: map['nguoiChi'] ,
      nguoiNhan: map['nguoiNhan'] ,
      noiDung: map['noiDung'] ,
      soCT: map['soCT'] ,
      tkNo: map['tkNo'] ,
      tkCo: map['tkCo'] ,
      pttt: map['pttt'] ,
      soTien: map['soTien'] ,
      createdBy: map['createdBy'] ,
      khoa: map['khoa'] ,
        stt: map['stt'],
        tongStt: map['tongStt'],
        idSau: map['idSau'],
        idTruoc: map['idTruoc']
    );
  }

  // PhieuChiModel copyWith({
  //   int? id,
  //   DateTime? ngay,
  //   String? phieu,
  //   String? maTC,
  //   String? maKH,
  //   String? maNV,
  //   String? tenKH,
  //   String? diaChi,
  //   String? nguoiChi,
  //   String? nguoiNhan,
  //   String? noiDung,
  //   String? soCT,
  //   String? tkNo,
  //   String? tkCo,
  //   String? pttt,
  //   num? soTien,
  //   String? createdBy,
  //   bool? khoa,
  // }) {
  //   return PhieuChiModel(
  //     id: id ?? this.id,
  //     ngay: ngay ?? this.ngay,
  //     phieu: phieu ?? this.phieu,
  //     maTC: maTC ?? this.maTC,
  //     maKH: maKH ?? this.maKH,
  //     maNV: maNV ?? this.maNV,
  //     tenKH: tenKH ?? this.tenKH,
  //     diaChi: diaChi ?? this.diaChi,
  //     nguoiChi: nguoiChi ?? this.nguoiChi,
  //     nguoiNhan: nguoiNhan ?? this.nguoiNhan,
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