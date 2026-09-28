import 'package:erp_client_1/features/thuchi/report/presentation/ui/state/bke_so_quy_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../notifier/bke_so_quy_tm_notifier.dart';


class BKeSoQuyTMScreen extends ConsumerStatefulWidget {
  const BKeSoQuyTMScreen({super.key});

  @override
  ConsumerState createState() => _BKeSoQuyTMScreenState();
}

class _BKeSoQuyTMScreenState extends ConsumerState<BKeSoQuyTMScreen> {
  late BKeSoQuyTableManager _manager;
  DateTime tN = DateTime.now().copyWith(day: 1);
  DateTime dN = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(bkeSoQuyTMProvider.notifier).get(tN, dN);
    });
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bkeSoQuyTMProvider);
    return Scaffold(
      footers: [AppFooter()],
      backgroundColor: AppColor.background,
      headers: [
        AppHeader(title: "Sổ chi tiết quỹ tiền mặt"),
        AppBar(
          leading: [

            // Gap(150),
            AppTngayDngay(
              onSubmit: (tn, dn){
                ref.read(bkeSoQuyTMProvider.notifier).get(tn, dn);
                tN = tn;
                dN = dN;
              },
            ),
          ],
        ),
        Divider(color: AppColor.border300,)
      ],
      child: state.when(
        data: (val) {
          return Scaffold(
            headers: [
              AppContainerBorder(
                child: AppBar(
                  leading: [
                    AppPrintButton(),
                  ],
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
                  title: ['Thu', 'Thu'],
                  width: 120,
                  columnType: ColumnType.num,
                  showFooter: true,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Chi', 'Chi'],
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
