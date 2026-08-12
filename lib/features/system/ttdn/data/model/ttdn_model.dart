class TTDNModel{
  final int id;
  final String ma;
  final String tieuDe;
  final String? noiDung;

  const TTDNModel({
    required this.id,
    required this.ma,
    required this.tieuDe,
    this.noiDung,
  });


  factory TTDNModel.fromMap(Map<String, dynamic> map) {
    return TTDNModel(
      id: map['id'],
      ma: map['ma'] ,
      tieuDe: map['tieuDe'] ,
      noiDung: map['noiDung']??"",
    );
  }

  TTDNModel copyWith({
    int? id,
    String? ma,
    String? tieuDe,
    String? noiDung,
  }) {
    return TTDNModel(
      id: id ?? this.id,
      ma: ma ?? this.ma,
      tieuDe: tieuDe ?? this.tieuDe,
      noiDung: noiDung ?? this.noiDung,
    );
  }

}