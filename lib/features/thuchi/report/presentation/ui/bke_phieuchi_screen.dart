import 'package:erp_client_1/features/thuchi/report/presentation/ui/state/bke_thuchi_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../../../chi/presentation/ui/phieuchi_screen.dart';
import '../notifier/bke_phieuchi_notifier.dart';

class BKePhieuChiScreen extends ConsumerStatefulWidget {
  const BKePhieuChiScreen({super.key});

  @override
  ConsumerState createState() => _BKePhieuChiScreenState();
}

class _BKePhieuChiScreenState extends ConsumerState<BKePhieuChiScreen> {
  late BKeThuChiTableManager _manager;
  DateTime tN = DateTime.now().copyWith(day: 1);
  DateTime dN = DateTime.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(bkePhieuChiProvider.notifier).get(tN, dN);
    });
  }


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bkePhieuChiProvider);
    return Scaffold(
      footers: [AppFooter()],
      backgroundColor: AppColor.background,
      headers: [
        // AppHeader(title: "Bảng kê phiếu chi"),
        AppContainerBorder(
          child: AppBar(
            leading: [
              // AppPrintButton(),
              // Gap(150),
              AppTngayDngay(
                onSubmit: (tn, dn){
                  ref.read(bkePhieuChiProvider.notifier).get(tn, dn);
                  tN = tn;
                  dN = dN;
                },
              ),
            ],
            trailing: [
              AppPrintButton()
            ],
          ),
        ),
      ],
      child: state.when(
        data: (val) {
          return Scaffold(
            // headers: [
            //   AppContainerBorder(
            //     child: AppBar(
            //       leading: [,],
            //     ),
            //   )
            // ],
            child: AppTable(
              onLoaded: (e){
                _manager = BKeThuChiTableManager(e.stateManager);
                _manager.loadView(val);
              },
              onRowDoubleTap: (re){
                final field = re.cell.column.field;
                if(field == "Phieu"){
                  showAppDialog(context, child: PhieuChiScreen(phieu: re.cell.value,));
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
