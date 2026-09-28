import 'dart:math';

import 'package:erp_client_1/features/soketoan/baocaotaichinh/data/model/bang_cdps_model.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/notifier/bangcdps_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/notifier/luusodu_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/ui/bang_cttk_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaotaichinh/presentation/ui/state/bang_cdps_table_manager.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../../../../ketchuyen/presentation/ui/ketchuyen_screen.dart';

class BangCDPSScreen extends ConsumerStatefulWidget {
  const BangCDPSScreen({super.key});

  @override
  ConsumerState createState() => _BangCDPSScreenState();
}

class _BangCDPSScreenState extends ConsumerState<BangCDPSScreen> {
  late BangCDPSTableManager _manager;

  int selectSoLieu = 4;
  int kieu = 2;
  DateTime dNgay = DateTime(DateTime.now().year, 12, 31);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(luuSoDuNotifier, (_, next) {
      next.whenOrNull(
        data: (val) {
          if (val) {
            showInfo(context, "Lưu thành công");
          }
        },
        error: (e, s) {
          showError(context, e.toString());
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bangCDPSProvider);
    final stateLuuSD = ref.watch(luuSoDuNotifier);
    return AppLoadingOverlay(
      isLoading: stateLuuSD.isLoading,
      child: Scaffold(
        footers: [AppFooter()],
        headers: [
          AppHeader(title: "Bảng cân đối phát sinh"),
          AppContainerBorder(
            child: AppBar(
              leading: [
                AppSelectDate(
                  selected: 2,
                  onSubmit: (t, d, type) {
                    ref.read(bangCDPSProvider.notifier).thucHien(selectSoLieu, t, d);
                    kieu = type;
                    dNgay = d;
                  },
                ),
              ],
              trailing: [
                SizedBox(
                  width: 250,
                  child: AppCombobox(
                    enabledClear: false,
                    value: selectSoLieu,
                    items: [
                      ComboboxItem(value: 0, text: ['Xem tất cả']),
                      ComboboxItem(value: 1, text: ['Tài khoản cha']),
                      ComboboxItem(value: 2, text: ['Tài khoản con']),
                      ComboboxItem(value: 3, text: ['Tài khoản có số phát sinh']),
                      ComboboxItem(value: 4, text: ['Tài khoản con có số phát sinh']),
                    ],
                    onChanged: (val) {
                      // _controller.onLoad(val);
                      ref.read(bangCDPSProvider.notifier).get(val);
                      setState(() {
                        selectSoLieu = val;
                      });
                    },
                  ),
                ),
                OutlineButton(
                  child: Text("Lưu số dư"),
                  onPressed: () {
                    ref.read(luuSoDuNotifier.notifier).save(dNgay, kieu);
                  },
                ),
                OutlineButton(
                  child: Text("Kết chuyển"),
                  onPressed: () {
                    showAppDialog(context, child: KetChuyenScreen());
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
                AppContainerBorder(child: AppBar(leading: [AppPrintButton()])),
              ],
              child: AppTable(
                onLoaded: (e) {
                  _manager = BangCDPSTableManager(e.stateManager);
                  _manager.loadView(val);
                },
                onRowDoubleTap: (event) {
                  if (event.cell.column.field == 'MaTK') {
                    showAppDialog(
                      context,
                      child: BangCTTKScreen(maTK: event.cell.value, year: dNgay.year.toString()),
                    );
                  }
                },
                readOnlyColor: Colors.yellow.shade200.withValues(alpha: .3),
                rowColorCallback: (re) {
                  if (re.row.cells['Cap']?.value == 1) {
                    return Colors.cyan.shade100;
                  }
                  return Colors.transparent;
                },
                columns: [
                  AppTableColumn(
                    title: ['Mã TK', 'MaTK'],
                    readOnly: true,
                    width: 70,
                    renderer: (re) => AppTableCell.textRed(re.cell.value).withAlign(Alignment.center),
                    columnAlign: ColumnAlign.center,
                  ),
                  AppTableColumn(title: ['Mô tả tài khoản', 'TenTK'], width: 300),
                  AppTableColumn(
                    title: ['Đầu kỳ nợ', 'DKNo'],
                    width: 140,
                    showFooter: true,
                    columnType: ColumnType.num,
                    textStyleFooter: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
                    renderer: (re) => AppTableCell.textRed(
                      NumHelper.numFormat(re.cell.value, lamTron: true),
                    ).withAlign(Alignment.centerRight),
                  ),
                  AppTableColumn(
                    title: ['Đầu kỳ có', 'DKCo'],
                    width: 140,
                    showFooter: true,
                    columnType: ColumnType.num,
                    textStyleFooter: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),

                    renderer: (re) => AppTableCell.textBlue(
                      NumHelper.numFormat(re.cell.value, lamTron: true),
                    ).withAlign(Alignment.centerRight),
                  ),
                  AppTableColumn(
                    title: ['Phát sinh nợ', 'PSNo'],
                    headerColor: Colors.yellow.shade100,

                    width: 140,
                    showFooter: true,
                    columnType: ColumnType.num,
                    // padding: 0,
                    readOnly: true,
                    textStyleFooter: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
                    renderer: (re) => AppTableCell.textRed(
                      NumHelper.numFormat(re.cell.value, lamTron: true),
                    ).withAlign(Alignment.centerRight),
                    // renderer: (re) => _buildText(re.cell.value, Colors.yellow.shade200, textColor: Colors.red.shade700),
                  ),
                  AppTableColumn(
                    title: ['Phát sinh có', 'PSCo'],
                    headerColor: Colors.yellow.shade100,
                    // padding: 0,
                    readOnly: true,
                    renderer: (re) => AppTableCell.textBlue(
                      NumHelper.numFormat(re.cell.value, lamTron: true),
                    ).withAlign(Alignment.centerRight),
                    width: 140,
                    showFooter: true,
                    columnType: ColumnType.num,
                    textStyleFooter: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                  ),
                  AppTableColumn(
                    title: ['Cuối kỳ nợ', 'CKNo'],
                    width: 140,
                    showFooter: true,
                    columnType: ColumnType.num,
                    textStyleFooter: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold),
                    renderer: (re) => AppTableCell.textRed(
                      NumHelper.numFormat(re.cell.value, lamTron: true),
                    ).withAlign(Alignment.centerRight),
                  ),
                  AppTableColumn(
                    title: ['Cuối kỳ có', 'CKCo'],
                    width: 140,
                    showFooter: true,
                    columnType: ColumnType.num,
                    renderer: (re) => AppTableCell.textBlue(
                      NumHelper.numFormat(re.cell.value, lamTron: true),
                    ).withAlign(Alignment.centerRight),
                    textStyleFooter: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold),
                  ),
                  AppTableColumn(title: ['', 'Cap'], hide: true),
                ],
              ),
            );
          },
          error: (e, s) => Center(child: Text(e.toString())),
          loading: () => Center(child: CircularProgressIndicator(size: 50)),
        ),
      ),
    );
  }
}
