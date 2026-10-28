import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/widget.dart';
import 'package:erp_client_1/features/ketchuyen/presentation/ui/ketchuyen_screen.dart';
import 'package:erp_client_1/features/soketoan/nhatky/presentation/notifier/nhatkychung_notifier.dart';
import 'package:erp_client_1/features/soketoan/nhatky/presentation/ui/state/nhatkychung_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NhatKyChungScreen extends ConsumerStatefulWidget {
  const NhatKyChungScreen({super.key});

  @override
  ConsumerState createState() => _NhatKyChungScreenState();
}

class _NhatKyChungScreenState extends ConsumerState<NhatKyChungScreen> {
  late NhatKyChungTableManager _manager;
  DateTime tuNgay = DateTime.now().copyWith(day: 1);
  DateTime denNgay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nhatKyChungProvider);
    return Scaffold(
      // backgroundColor: AppColor.background,
      footers: [
        AppFooter()
      ],
      headers: [
        // AppHeader(title: "Sổ nhật ký chung",),
        AppContainerBorder(
          child: AppBar(
            leading: [
              AppTngayDngay(
                onSubmit: (t, d) {
                  tuNgay = t;
                  denNgay = d;
                  ref.read(nhatKyChungProvider.notifier).get(tuNgay, denNgay);
                },
              ),
            ],
            trailing: [
              OutlineButton(
                child: Text("Kết chuyển"),
                onPressed: (){
                  showAppDialog(context, child: KetChuyenScreen());
                },
              ),
            ],
          ),
        ),
        Divider(color: AppColor.border300),
      ],
      child: state.when(
        data: (val) {
          return Scaffold(
            child: AppTable(
              onLoaded: (e){
                _manager = NhatKyChungTableManager(e.stateManager);
                _manager.loadView(val);
              },
              columns: [
                AppTableColumn(
                  title: ['#', 'stt'],
                  readOnly: true,
                  showFilter: false,
                  width: 35,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                ),
                AppTableColumn(
                  title: ['Ngày ghi sổ', 'Ngay'],
                  width: 100,
                  columnType: ColumnType.date,
                  columnAlign: ColumnAlign.center,
                ),
                AppTableColumn(title: ['Số CT', 'ChungTu'], width: 100, columnAlign: ColumnAlign.center),
                AppTableColumn(
                  title: ['Ngày CT', 'NgayCT'],
                  width: 90,
                  columnType: ColumnType.date,
                  columnAlign: ColumnAlign.center,
                ),
                AppTableColumn(title: ['Diễn giải', 'DienGiai'], width: 330),
                AppTableColumn(title: ['TK nợ', 'TKNo'], width: 80, columnAlign: ColumnAlign.center),
                AppTableColumn(title: ['TK có', 'TKCo'], width: 80, columnAlign: ColumnAlign.center),
                AppTableColumn(
                  title: ['Số phát sinh', 'SoPS'],
                  width: 180,
                  columnType: ColumnType.num,
                  columnAlign: ColumnAlign.right,
                  showFooter: true,
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
