class SoThueModel{
  final int id;
  final String nam;
  final num? soKyTruoc;
  final num? soBaoCao;
  final num? soKiemTra;
  final num? soPhaiNop;
  final num? soDaNop;
  final num? conPhaiNop;

  const SoThueModel({
    required this.id,
    required this.nam,
    this.soKyTruoc,
    this.soBaoCao,
    this.soKiemTra,
    this.soPhaiNop,
    this.soDaNop,
    this.conPhaiNop,
  });

  factory SoThueModel.fromMap(Map<String, dynamic> map) {
    return SoThueModel(
      id: map['id'] ,
      nam: map['nam'] ,
      soKyTruoc: map['soKyTruoc'] ,
      soBaoCao: map['soBaoCao'] ,
      soKiemTra: map['soKiemTra'] ,
      soPhaiNop: map['soPhaiNop'] ,
      soDaNop: map['soDaNop'] ,
      conPhaiNop: map['conPhaiNop'],
    );
  }
}

class UpdateGTGTModel{
  final num? soBaoCao;
  final num? soDaNop;

  const UpdateGTGTModel({
    this.soBaoCao,
    this.soDaNop,
  });

  Map<String, dynamic> toMap() {
    return {
      'soBaoCao': soBaoCao,
      'soDaNop': soDaNop,
    };
  }
}

class UpdateTNDNModel{
  final num? soBaoCao;
  final num? soDaNop;
  final num? soKiemTra;
  final num? soPhaiNop;

  const UpdateTNDNModel({
    this.soBaoCao,
    this.soDaNop,
    this.soKiemTra,
    this.soPhaiNop,
  });

  Map<String, dynamic> toMap() {
    return {
      'soBaoCao': soBaoCao,
      'soDaNop': soDaNop,
      'soKiemTra': soKiemTra,
      'soPhaiNop': soPhaiNop,
    };
  }


}

class UpdateTNCNModel{
  final num? soBaoCao;
  final num? soDaNop;
  final num? soKiemTra;

  const UpdateTNCNModel({
    this.soBaoCao,
    this.soDaNop,
    this.soKiemTra,
  });

  Map<String, dynamic> toMap() {
    return {
      'soBaoCao': soBaoCao,
      'soDaNop': soDaNop,
      'soKiemTra': soKiemTra,
    };
  }


}