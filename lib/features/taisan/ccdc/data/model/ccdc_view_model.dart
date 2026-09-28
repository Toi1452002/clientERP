class CCDCViewModel{
  final int id;
  final int? hangHoaId;
  final String? tenHH;
  final String? boPhanSD;
  final num? soLuong;
  final num? giaTri;
  final DateTime? ngayMua;
  final DateTime? ngaySD;
  final int? soThangPB;
  final num? giaTriKhauHao;
  final num? luyKe;
  final num? giaTriConLai;
  final String? tkChiPhi;
  final String? tkHaoMon;

  const CCDCViewModel({
    required this.id,
    this.hangHoaId,
    this.tenHH,
    this.boPhanSD,
    this.soLuong,
    this.giaTri,
    this.ngayMua,
    this.ngaySD,
    this.soThangPB,
    this.giaTriKhauHao,
    this.luyKe,
    this.giaTriConLai,
    this.tkChiPhi,
    this.tkHaoMon,
  });

  factory CCDCViewModel.fromMap(Map<String, dynamic> map) {
    return CCDCViewModel(
      id: map['id'] ,
      hangHoaId: map['hangHoaId'] ,
      tenHH: map['tenHH'] ,
      boPhanSD: map['boPhanSD'] ,
      soLuong: map['soLuong'] ,
      giaTri: map['giaTri'] ,
      ngayMua: map['ngayMua']==null?null:DateTime.tryParse(map['ngayMua']) ,
      ngaySD: map['ngaySD']==null?null:DateTime.tryParse(map['ngaySD']) ,
      soThangPB: map['soThangPB'] ,
      giaTriKhauHao: map['giaTriKhauHao'] ,
      luyKe: map['luyKe'] ,
      giaTriConLai: map['giaTriConLai'] ,
      tkChiPhi: map['tkChiPhi'] ,
      tkHaoMon: map['tkHaoMon'] ,
    );
  }
}