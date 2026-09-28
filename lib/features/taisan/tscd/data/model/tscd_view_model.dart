class TSCDViewModel{
  final int id;
  final int? hangHoaId;
  final String? tenHH;
  final String? boPhanSD;
  final num? nguyenGia;
  final DateTime? ngayMua;
  final DateTime? ngaySD;
  final int? soNamPB;
  final int? soThangPB;
  final num? giaTriKhauHao;
  final num? luyKe;
  final num? giaTriConLai;
  final String? tkChiPhi;
  final String? tkHaoMon;

  const TSCDViewModel({
    required this.id,
    required this.hangHoaId,
    required this.tenHH,
    this.boPhanSD,
    this.nguyenGia,
    this.ngayMua,
    this.ngaySD,
    this.soNamPB,
    this.soThangPB,
    this.giaTriKhauHao,
    this.luyKe,
    this.giaTriConLai,
    this.tkChiPhi,
    this.tkHaoMon,
  });


  factory TSCDViewModel.fromMap(Map<String, dynamic> map) {
    return TSCDViewModel(
      id: map['id'] ,
      hangHoaId: map['hangHoaId'] ,
      tenHH: map['tenHH'] ,
      boPhanSD: map['boPhanSD'] ,
      nguyenGia: map['nguyenGia'] ,
      ngayMua: map['ngayMua']==null?null:DateTime.tryParse(map['ngayMua']) ,
      ngaySD: map['ngaySD']==null?null:DateTime.tryParse(map['ngaySD']) ,
      soNamPB: map['soNamPB'] ,
      soThangPB: map['soThangPB'] ,
      giaTriKhauHao: map['giaTriKhauHao'] ,
      luyKe: map['luyKe'] ,
      giaTriConLai: map['giaTriConLai'] ,
      tkChiPhi: map['tkChiPhi'] ,
      tkHaoMon: map['tkHaoMon'] ,
    );
  }
}