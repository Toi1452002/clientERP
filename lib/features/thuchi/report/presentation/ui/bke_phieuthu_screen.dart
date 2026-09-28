import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/notifier/bke_phieuthu_notifier.dart';
import 'package:erp_client_1/features/thuchi/report/presentation/ui/state/bke_thuchi_table_manager.dart';
import 'package:erp_client_1/features/thuchi/thu/presentation/ui/phieuthu_screen.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';

class BKePhieuThuScreen extends ConsumerStatefulWidget {
  const BKePhieuThuScreen({super.key});

  @override
  ConsumerState createState() => _BKePhieuThuScreenState();
}

class _BKePhieuThuScreenState extends ConsumerState<BKePhieuThuScreen> {
  late BKeThuChiTableManager _manager;
  DateTime tN = DateTime.now().copyWith(day: 1);
  DateTime dN = DateTime.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(bkePhieuThuProvider.notifier).get(tN, dN);
    });
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bkePhieuThuProvider);
    return Scaffold(
      footers: [AppFooter()],
      backgroundColor: AppColor.background,
      headers: [
        AppHeader(title: "Bảng kê phiếu thu"),
        AppContainerBorder(
          child: AppBar(
            leading: [
              //
              // Gap(150),
              AppTngayDngay(
                onSubmit: (tn, dn){
                  ref.read(bkePhieuThuProvider.notifier).get(tn, dn);
                  tN = tn;
                  dN = dN;
                },
              ),
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
                  leading: [AppPrintButton(),],
                ),
              )
            ],
            child: AppTable(
              onLoaded: (e){
                _manager = BKeThuChiTableManager(e.stateManager);
                _manager.loadView(val);
              },
              onRowDoubleTap: (re){
                final field = re.cell.column.field;
                if(field == "Phieu"){
                  showAppDialog(context, child: PhieuThuScreen(phieu: re.cell.value,));
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
                  width: 80,
                  columnType: ColumnType.date,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(
                  title: ['Phiếu', 'Phieu'],
                  width: 70,
                  renderer: (re) => AppTableCell.textRed(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Kiểu chi', 'Kieu'],
                  width: 100,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Mã KH', 'MaKH'],
                  width: 80,
                  renderer: (re) => AppTableCell.textRed(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Tên khách', 'TenKH'],
                  width: 300,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['PTTT', 'PTTT'],
                  width: 75,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(
                  title: ['Lý do chi', 'NoiDung'],
                  width: 250,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Số tiền', 'SoTien'],
                  width: 100,
                  columnType: ColumnType.num,
                  showFooter: true,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['TK nợ', 'TKNo'],
                  width: 75,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(
                  title: ['TK có', 'TKCo'],
                  width: 75,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
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
