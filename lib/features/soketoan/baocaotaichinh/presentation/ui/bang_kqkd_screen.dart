import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/ui/state/bang_tmp_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../notifier/bang_tmp_bctc_notifier.dart';
import '../notifier/luusodu_notifier.dart';

class BangKQKDScreen extends ConsumerStatefulWidget {
  const BangKQKDScreen({super.key});

  @override
  ConsumerState createState() => _BangKQKDScreenState();
}

class _BangKQKDScreenState extends ConsumerState<BangKQKDScreen> {
  late BangTmpTableManager _manager;
  final txtNam = TextEditingController(text: (DateTime.now().year - 1).toString());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bangTmpCBTCProvider.notifier).get("KQKD", DateTime.now().year - 1);
    });

    ref.listenManual(luuNamTruocNotifier, (_, next) {
      next.whenOrNull(
        data: (val) {
          showInfo(context, "Lưu thành công");
        },
        error: (e, _) => showInfo(context, e.toString()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bangTmpCBTCProvider);
    final stateSave = ref.watch(luuNamTruocNotifier);
    return AppLoadingOverlay(
      isLoading: stateSave.isLoading,
      child: Scaffold(
        footers: [AppFooter()],
        headers: [
          // AppHeader(title: "Báo cáo kết quả kinh doanh"),
          AppContainerBorder(
            child: AppBar(
              leading: [
                Text('Năm').medium,
                SizedBox(width: 70, child: AppTextField(isNumber: true, controller: txtNam)),
                OutlineButton(
                  child: Text("Thực hiện"),
                  onPressed: () {
                    ref
                        .read(bangTmpCBTCProvider.notifier)
                        .get("KQKD", int.tryParse(txtNam.text) ?? DateTime.now().year - 1);
                  },
                ),
              ],
              trailing: [
                OutlineButton(
                  child: Text('Lưu lại số năm nay'),
                  onPressed: () {
                    ref
                        .read(luuNamTruocNotifier.notifier)
                        .save("KQKD", int.tryParse(txtNam.text) ?? DateTime.now().year - 1);
                  },
                ),
              ],
            ),
          ),
        ],
        child: state.when(
          data: (val) {
            return AppTable(
              onLoaded: (e) {
                _manager = BangTmpTableManager(e.stateManager);
                _manager.loadView(val);
              },
              rowColorCallback: (re) {
                if (re.row.cells['PhanCap']?.value == 2) {
                  return Colors.amber.shade100;
                } else if (re.row.cells['PhanCap']?.value == 1) {
                  return Colors.cyan.shade100;
                } else {
                  return Colors.transparent;
                }
              },
              columns: [
                AppTableColumn(
                  title: ['#', 'stt'],
                  width: 35,
                  readOnly: true,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                ),
                AppTableColumn(
                  title: ['Chỉ tiêu', 'ChiTieu'],
                  width: 300,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Mã số', 'MaSo'],
                  width: 70,
                  columnAlign: ColumnAlign.center,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(title: ['Thuyết minh', 'ThuyetMinh'], width: 300),
                AppTableColumn(
                  title: ['Số năm nay', 'SoNamNay'],
                  width: 130,
                  columnType: ColumnType.num,
                  renderer: (re) => AppTableCell.textRed(
                    NumHelper.numFormat(re.cell.value, lamTron: true),
                  ).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Số năm trước', 'SoNamTruoc'],
                  width: 130,
                  columnType: ColumnType.num,
                  renderer: (re) => AppTableCell.textBlue(
                    NumHelper.numFormat(re.cell.value, lamTron: true),
                  ).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(title: ['PhanCap', 'PhanCap'], hide: true),
              ],
            );
          },
          error: (e, s) => Center(child: Text(e.toString())),
          loading: () => Center(child: CircularProgressIndicator(size: 50)),
        ),
      ),
    );
  }
}
