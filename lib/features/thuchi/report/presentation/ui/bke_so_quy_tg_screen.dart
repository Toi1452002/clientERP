import 'package:erp_client_1/features/thuchi/report/presentation/notifier/bke_so_quy_tg_notifier.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/ui/state/bke_so_quy_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../../../../nhapxuat/nhap/presentation/ui/phieunhap_screen.dart';
import '../../../../nhapxuat/xuat/presentation/ui/phieuxuat_screen.dart';
import '../../../chi/presentation/ui/phieuchi_screen.dart';
import '../../../thu/presentation/ui/phieuthu_screen.dart';


class BKeSoQuyTGScreen extends ConsumerStatefulWidget {
  const BKeSoQuyTGScreen({super.key});

  @override
  ConsumerState createState() => _BKeSoQuyTGScreenState();
}

class _BKeSoQuyTGScreenState extends ConsumerState<BKeSoQuyTGScreen> {
  late BKeSoQuyTableManager _manager;
  DateTime tN = DateTime.now().copyWith(day: 1);
  DateTime dN = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(bkeSoQuyTGProvider.notifier).get(tN, dN);
    });
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bkeSoQuyTGProvider);
    return Scaffold(
      footers: [AppFooter()],
      backgroundColor: AppColor.background,
      headers: [
        // AppHeader(title: "Sổ chi tiết quỹ tiền gửi"),
        AppContainerBorder(
          child: AppBar(
            leading: [
          
              AppTngayDngay(
                onSubmit: (tn, dn){
                  ref.read(bkeSoQuyTGProvider.notifier).get(tn, dn);
                  tN = tn;
                  dN = dN;
                },
              ),
            ],
            trailing: [
              AppPrintButton(),

            ],
          ),
        ),
      ],
      child: state.when(
        data: (val) {
          return Scaffold(
            headers: [
              AppContainerBorder(
                child: AppBar(
                  trailing: [
                    Text('Tồn đầu kỳ: '),
                    Text(NumHelper.numFormat(val?.dauKy),style: TextStyle(fontWeight: FontWeight.w700,))
                  ],
                ),
              )
            ],
            footers: [
              AppContainerBorder(
                child: AppBar(
                  trailing: [
                    Text('Tồn cuối kỳ: '),
                    Text(NumHelper.numFormat(val?.cuoiKy),style: TextStyle(fontWeight: FontWeight.w700,))
                  ],
                ),
              )
            ],
            child: AppTable(
              onLoaded: (e){
                _manager = BKeSoQuyTableManager(e.stateManager);
                if(val!=null){
                  _manager.loadView(val.bkeSoQuy);
                }
              },
              onRowDoubleTap: (re){
                final field = re.cell.column.field;
                if(field == "Phieu"){
                  if(re.cell.value.toString().startsWith("T")){
                    showAppDialog(context, child: PhieuThuScreen(phieu: re.cell.value,));
                  }else if(re.cell.value.toString().startsWith("C")){
                    showAppDialog(context, child: PhieuChiScreen(phieu: re.cell.value,));
                  }else if(re.cell.value.toString().startsWith("N")){
                    showAppDialog(context, child: PhieuNhapScreen(phieu: re.cell.value,));

                  }else if(re.cell.value.toString().startsWith("X")){
                    showAppDialog(context, child: PhieuXuatScreen(phieu: re.cell.value,));
                  }
                }
              },
              columns: [
                AppTableColumn(
                  title: ['#', 'stt'],
                  width: 35,
                  readOnly: true,
                  showFilter: false,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                ),
                AppTableColumn(
                  title: ['Ngày', 'Ngay'],
                  width: 90,
                  columnType: ColumnType.date,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(title: ['Phiếu', 'Phieu'], width: 90, renderer: (re) => AppTableCell.textRed(re.cell.value)),
                AppTableColumn(
                  title: ['Lý do', 'DienGiai'],
                  width: 250,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(title: ['Kiểu', 'Kieu'], width: 100, renderer: (re) => AppTableCell.textBlue(re.cell.value)),
                AppTableColumn(
                  title: ['PTTT', 'PTTT'],
                  width: 80,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(
                  title: ['Số CT', 'ChungTu'],
                  width: 90,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['TKĐƯ', 'TKDU'],
                  width: 80,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(
                  title: ['Gửi vào', 'Thu'],
                  width: 120,
                  columnType: ColumnType.num,
                  showFooter: true,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Rút ra', 'Chi'],
                  width: 120,
                  columnType: ColumnType.num,
                  showFooter: true,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
              ],
            ),
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
