import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/chuyenlo_ct_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/notifier/chuyenlo_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/state/chuyenlo_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/num_helper.dart';

class ChuyenLoCTScreen extends ConsumerStatefulWidget {
  final int year;
  final int chuyenLoId;

  const ChuyenLoCTScreen({super.key, required this.year, required this.chuyenLoId});

  @override
  ConsumerState createState() => _ChuyenLoCTScreenState();
}

class _ChuyenLoCTScreenState extends ConsumerState<ChuyenLoCTScreen> {
  late ChuyenLoCTTableManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chuyenLoCTProvider.notifier).get(widget.chuyenLoId, widget.year);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chuyenLoCTProvider);
    return DialogWindows(
      width: 700,
      height: 280,
      title: widget.year.toString(),
      child: Scaffold(
        child: state.when(
          data: (val) {
            return AppTable(
              onLoaded: (e) {
                _manager = ChuyenLoCTTableManager(e.stateManager);
                _manager.loadView(val);
              },
              onChange: (event) async {
                // final field = event.column.field;
                final id = event.row.cells['Id']?.value;
                final slPS = event.row.cells['SoLoPS']?.value;
                final kT = event.row.cells['LoDaChuyenKyTruoc']?.value;
                final kN = event.row.cells['LoDuocChuyenKyNay']?.value;
                event.row.cells['LoDuocChuyenKySau']?.value = slPS - kT - kN;
                final kS = event.row.cells['LoDuocChuyenKySau']?.value;

                try {
                  await ref
                      .read(chuyenLoCTProvider.notifier)
                      .updateCT(
                        ChuyenLoCTModel(
                          id: id,
                          namPSLo: '',
                          loDaChuyenKyTruoc: kT,
                          loDuocChuyenKyNay: kN,
                          loDuocChuyenKySau: kS,
                          conLo: slPS - kT - kN > 0,
                        ),
                      );
                } catch (e) {
                  showInfo(context, e.toString());
                }
              },
              columnHeight: 60,
              columns: [
                AppTableColumn(
                  title: ['#', 'stt'],
                  width: 35,
                  readOnly: true,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                ),
                AppTableColumn(title: ['', 'Id'], hide: true),
                AppTableColumn(title: ['', 'ConLo'], hide: true),
                AppTableColumn(
                  title: ['Năm PS lỗ', 'NamPSlo'],
                  width: 100,
                  readOnly: true,
                  columnAlign: ColumnAlign.center,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(
                  title: ['Số lỗ phát sinh', 'SoLoPS'],
                  width: 130,
                  columnType: ColumnType.num,
                  showFooter: true,
                  readOnly: true,
                  renderer: (re) => AppTableCell.textBlue(
                    NumHelper.numFormat(re.cell.value, lamTron: true),
                  ).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Số lỗ đã chuyển trong các kỳ tính thuế trước', 'LoDaChuyenKyTruoc'],
                  width: 130,
                  columnType: ColumnType.num,
                  columnAlign: ColumnAlign.right,
                  showFooter: true,
                  isEdit: true,
                  titleRenderer: (rendererContext) {
                    return customTitle(rendererContext.column.title);
                  },
                ),
                AppTableColumn(
                  title: ['Số lỗ đã chuyển\ntrong các kỳ tính\nthuế này', 'LoDuocChuyenKyNay'],
                  width: 130,
                  columnType: ColumnType.num,
                  columnAlign: ColumnAlign.right,
                  showFooter: true,
                  isEdit: true,
                  titleRenderer: (rendererContext) {
                    return customTitle(rendererContext.column.title);
                  },
                ),
                AppTableColumn(
                  title: ['Số lỗ đã chuyển\ntrong các kỳ tính\nthuế sau', 'LoDuocChuyenKySau'],
                  width: 130,
                  columnType: ColumnType.num,
                  showFooter: true,
                  readOnly: true,
                  renderer: (re) => AppTableCell.textBlue(
                    NumHelper.numFormat(re.cell.value, lamTron: true),
                  ).withAlign(Alignment.centerRight),
                  titleRenderer: (rendererContext) {
                    return customTitle(rendererContext.column.title);
                  },
                ),
              ],
            );
          },
          error: (e, s) => Center(child: Text(e.toString())),
          loading: () => Center(child: CircularProgressIndicator(size: 50)),
        ),
      ),
    );
  }

  Widget customTitle(String text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.gray.shade100,
        border: Border(right: BorderSide(color: AppColor.border300)),
      ),
      child: Center(child: Text(text, textAlign: TextAlign.center, softWrap: true).medium),
    );
  }
}
