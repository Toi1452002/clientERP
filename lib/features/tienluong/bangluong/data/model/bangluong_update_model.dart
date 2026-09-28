class BangLuongUpdateModel{
  final String? maNV;
  final num? luongCoBan;
  final num? ngayCong;
  final num? tamUng;
  final String? chucVu;

  const BangLuongUpdateModel({
    this.maNV,
    this.luongCoBan,
    this.ngayCong,
    this.tamUng,
    this.chucVu,
  });

  Map<String, dynamic> toMap() {
    return {
      'maNV': maNV,
      'luongCoBan': luongCoBan,
      'ngayCong': ngayCong,
      'tamUng': tamUng,
      'chucVu': chucVu,
    };
  }

  // factory BangLuongUpdateModel.fromMap(Map<String, dynamic> map) {
  //   return BangLuongUpdateModel(
  //     maNV: map['maNV'] as String,
  //     luongCoBan: map['luongCoBan'] as num,
  //     ngayCong: map['ngayCong'] as num,
  //     tamUng: map['tamUng'] as num,
  //     chucVu: map['chucVu'] as String,
  //   );
  // }

}