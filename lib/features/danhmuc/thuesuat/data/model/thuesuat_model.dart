class ThueSuatModel{
  final num? value;
  final String moTa;

  const ThueSuatModel({
    required this.value,
    required this.moTa,
  });

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'moTa': moTa,
    };
  }

  factory ThueSuatModel.fromMap(Map<String, dynamic> map) {
    return ThueSuatModel(
      value: map['value'],
      moTa: map['moTa'],
    );
  }

}