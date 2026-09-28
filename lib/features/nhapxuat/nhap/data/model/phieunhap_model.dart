class PhieuNhapModel{
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
  final String? soCT;
  final DateTime? ngayCT;
  final String tkNo;
  final String tkCo;
  final String tkVatNo;
  final String tkVatCo;
  final String pttt;
  final int stt;
  final int tongStt;
  final int? idTruoc;
  final int? idSau;

  const PhieuNhapModel({
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
    this.soCT,
    this.ngayCT,
    required this.tkNo,
    required this.tkCo,
    required this.tkVatNo,
    required this.tkVatCo,
    required this.pttt,
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
  //     'maKH': this.maKH,
  //     'maNX': this.maNX,
  //     'dienGiai': this.dienGiai,
  //     'congTien': this.congTien,
  //     'thueSuat': this.thueSuat,
  //     'tienThue': this.tienThue,
  //     'khoa': this.khoa,
  //     'createdBy': this.createdBy,
  //     'kyHieu': this.kyHieu,
  //     'soCT': this.soCT,
  //     'ngayCT': this.ngayCT,
  //     'tkNo': this.tkNo,
  //     'tkCo': this.tkCo,
  //     'tkVatNo': this.tkVatNo,
  //     'tkVatCo': this.tkVatCo,
  //     'pttt': this.pttt,
  //   };
  // }

  factory PhieuNhapModel.fromMap(Map<String, dynamic> map) {
    return PhieuNhapModel(
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
      soCT: map['soCT'] ,
      ngayCT: DateTime.tryParse(map['ngayCT']??"") ,
      tkNo: map['tkNo'] ,
      tkCo: map['tkCo'] ,
      tkVatNo: map['tkVatNo'] ,
      tkVatCo: map['tkVatCo'] ,
      pttt: map['pttt'] ,
      stt: map['stt'],
      tongStt: map['tongStt'],
      idSau: map['idSau'],
      idTruoc: map['idTruoc']
    );
  }

  // PhieuNhapModel copyWith({
  //   int? id,
  //   DateTime? ngay,
  //   String? phieu,
  //   String? maKH,
  //   String? maNX,
  //   String? dienGiai,
  //   num? congTien,
  //   int? thueSuat,
  //   num? tienThue,
  //   bool? khoa,
  //   String? createdBy,
  //   String? kyHieu,
  //   String? soCT,
  //   DateTime? ngayCT,
  //   String? tkNo,
  //   String? tkCo,
  //   String? tkVatNo,
  //   String? tkVatCo,
  //   String? pttt,
  //   int? stt,
  //   int? tongStt,
  //   int? idTruoc, int? idSau
  // }) {
  //   return PhieuNhapModel(
  //     id: id ?? this.id,
  //     ngay: ngay ?? this.ngay,
  //     phieu: phieu ?? this.phieu,
  //     maKH: maKH ?? this.maKH,
  //     maNX: maNX ?? this.maNX,
  //     dienGiai: dienGiai ?? this.dienGiai,
  //     congTien: congTien ?? this.congTien,
  //     thueSuat: thueSuat ?? this.thueSuat,
  //     tienThue: tienThue ?? this.tienThue,
  //     khoa: khoa ?? this.khoa,
  //     createdBy: createdBy ?? this.createdBy,
  //     kyHieu: kyHieu ?? this.kyHieu,
  //     soCT: soCT ?? this.soCT,
  //     ngayCT: ngayCT ?? this.ngayCT,
  //     tkNo: tkNo ?? this.tkNo,
  //     tkCo: tkCo ?? this.tkCo,
  //     tkVatNo: tkVatNo ?? this.tkVatNo,
  //     tkVatCo: tkVatCo ?? this.tkVatCo,
  //     pttt: pttt ?? this.pttt, stt: stt??this.stt, tongStt: tongStt??this.tongStt,
  //     idTruoc: idTruoc??this.idTruoc,
  //     idSau: idSau??this.idSau
  //   );
  // }
}