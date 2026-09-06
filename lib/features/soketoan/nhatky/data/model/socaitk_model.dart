class SoCaiTkModel{
    final DateTime ngay;
    final DateTime ngayCT;
    final String chungTu;
    final String? dienGiai;
    final String tkdu;
    final num psNo;
    final num psCo;

  const SoCaiTkModel({
    required this.ngay,
    required this.ngayCT,
    required this.chungTu,
    this.dienGiai,
    required this.tkdu,
    required this.psNo,
    required this.psCo,
  });


  factory SoCaiTkModel.fromMap(Map<String, dynamic> map) {
    return SoCaiTkModel(
      ngay: DateTime.parse(map['ngay']) ,
      ngayCT: DateTime.parse(map['ngayCT']) ,
      chungTu: map['chungTu'] ,
      dienGiai: map['dienGiai'] ,
      tkdu: map['tkdu'] ,
      psNo: map['psNo'] ,
      psCo: map['psCo'] ,
    );
  }
}

class SoCaiTKViewModel{
  final List<SoCaiTkModel> soCaiTK;
  final num dkNo;
  final num dkCo;
  final num ckNo;
  final num ckCo;

  const SoCaiTKViewModel({
    required this.soCaiTK,
    required this.dkNo,
    required this.dkCo,
    required this.ckNo,
    required this.ckCo,
  });


  factory SoCaiTKViewModel.fromMap(Map<String, dynamic> map) {
    final soCai = map['soCaiTK'] as List;
    return SoCaiTKViewModel(
      soCaiTK: soCai.map((e)=>SoCaiTkModel.fromMap(e)).toList(),
      dkNo: map['dkNo'] ,
      dkCo: map['dkCo'] ,
      ckNo: map['ckNo'] ,
      ckCo: map['ckCo'] ,
    );
  }}