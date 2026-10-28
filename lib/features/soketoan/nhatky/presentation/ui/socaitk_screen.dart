import 'package:collection/collection.dart';
import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/utils/num_helper.dart';
import 'package:erp_client_1/core/widgets/widget.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/widget/taikhoan_socai_combobox.dart';
import 'package:erp_client_1/features/soketoan/nhatky/presentation/notifier/socaitk_notifier.dart';
import 'package:erp_client_1/features/soketoan/nhatky/presentation/ui/state/socaitk_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../danhmuc/taikhoan/data/model/taikhoan_lookup_model.dart';
import '../../../../danhmuc/taikhoan/presentation/ui/state/taikhoan_lookup_state.dart';

class SoCaiTKScreen extends ConsumerStatefulWidget {
  const SoCaiTKScreen({super.key});

  @override
  ConsumerState createState() => _SoCaiTKScreenState();
}

class _SoCaiTKScreenState extends ConsumerState<SoCaiTKScreen> {
  late SoCaiTKTableManager _manager;
  DateTime tuNgay = DateTime.now().copyWith(day: 1);
  DateTime denNgay = DateTime.now();
  String? maTK;
  final txtTenTK = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(soCaiTKProvider);
    return Scaffold(
      backgroundColor: AppColor.background,
      footers: [
        AppFooter()
      ],
      headers: [
        // AppHeader(title: "Sổ cái tài khoản"),
        AppContainerBorder(child: Column(
          children: [

            AppBar(
              leading: [
                Text("Mã TK").medium,
                Gap(5),
                SizedBox(width: 100,child: TaiKhoanSoCaiCombobox(selected: maTK,onChanged: (val){
                  ref.read(soCaiTKProvider.notifier).get(val, tuNgay, denNgay);
                  setState(() {
                    maTK=val;

                  });
                  if(val!=null){
                    final x = ref.read(taiKhoanLookupProvider(LoaiTaiKhoan.soCai)).value;
                    final t = x?.firstWhereOrNull((e)=>e.maTK == val);
                    if(t!=null) txtTenTK.text = t.tenTK;
                  }else{
                    txtTenTK.clear();
                  }
                },),),
                SizedBox(width: 250,child: AppTextField(controller: txtTenTK,readOnly: true,),),
              ],
            ),
            AppBar(
              leading: [
                AppTngayDngay(
                  onSubmit: (t,d){
                    tuNgay = t;
                    denNgay = d;
                    if(maTK != null){
                      ref.read(soCaiTKProvider.notifier).get(maTK!, tuNgay, denNgay);
                    }
                  },
                )
              ],
              trailing: [
                AppPrintButton()
              ],
            ),
          ],
        )),

        // Divider(color: AppColor.border300,)
      ],
      child: state.when(
        data: (val) {
          return Scaffold(
            footers: [
              AppContainerBorder(
                child: AppBar(
                  trailing: [
                    Text('Số dư cuối kỳ: '),
                    Text("[NỢ]",style: TextStyle(color: Colors.gray),),
                    Text(NumHelper.numFormat(val?.ckNo),style: TextStyle(fontWeight: FontWeight.w500),),
                    Gap(5),
                    VerticalDivider(),
                    Gap(5),
                    Text("[CÓ]",style: TextStyle(color: Colors.gray)),
                    Text(NumHelper.numFormat(val?.ckCo),style: TextStyle(fontWeight: FontWeight.w500),),
                
                  ],
                ),
              )
            ],
            headers: [
              AppContainerBorder(
                child: AppBar(
                  trailing: [
                    Text('Số dư đầu kỳ: '),
                    Text("[NỢ]",style: TextStyle(color: Colors.gray),),
                    Text(NumHelper.numFormat(val?.dkNo),style: TextStyle(fontWeight: FontWeight.w500),),
                    Gap(5),
                    VerticalDivider(),
                    Gap(5),
                    Text("[CÓ]",style: TextStyle(color: Colors.gray)),
                    Text(NumHelper.numFormat(val?.dkCo),style: TextStyle(fontWeight: FontWeight.w500),),
                
                  ],
                ),
              )
            ],
            child: AppTable(
              onLoaded: (e){
                _manager = SoCaiTKTableManager(e.stateManager);
                if(val != null){
                  _manager.loadView(val.soCaiTK);
                }
              },
              columns: [
                AppTableColumn(
                  title: ['#', 'stt'],
                  showFilter: false,
                  readOnly: true,
                  width: 35,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                ),
                AppTableColumn(
                  title: ['Ngày ghi sổ', 'Ngay'],
                  width: 110,
                  columnType: ColumnType.date,
                  columnAlign: ColumnAlign.center,
                ),
                AppTableColumn(
                  title: ['Số CT', 'ChungTu'],
                  width: 100,
                  columnAlign: ColumnAlign.center,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Ngày CT', 'NgayCT'],
                  width: 100,
                  columnType: ColumnType.date,
                  columnAlign: ColumnAlign.center,
                ),
                AppTableColumn(title: ['Diễn giải', 'DienGiai'], width: 300),
                AppTableColumn(title: ['TKDU', 'TKDU'], width: 80, columnAlign: ColumnAlign.center),
                AppTableColumn(
                  title: ['Nợ', 'PSNo'],
                  width: 130,
                  columnType: ColumnType.num,
                  showFooter: true,
                  columnAlign: ColumnAlign.right,
                ),
                AppTableColumn(
                  title: ['Có', 'PSCo'],
                  width: 130,
                  columnType: ColumnType.num,
                  showFooter: true,
                  columnAlign: ColumnAlign.right,
                ),
              ],
            ),
          );
        },
        error: (e, s) => Center(child: Text((e.toString()))),
        loading: () => Center(child: CircularProgressIndicator(size: 50,)),
      ),
    );
  }
}
