import 'dart:math';

import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/notifier/chuyenlo_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/chuyenlo_ct_screen.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/state/chuyenlo_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../core/utils/num_helper.dart';

class ChuyenLoScreen extends ConsumerStatefulWidget {
  const ChuyenLoScreen({super.key});

  @override
  ConsumerState createState() => _ChuyenLoScreenState();
}

class _ChuyenLoScreenState extends ConsumerState<ChuyenLoScreen> {
  late ChuyenLoTableManager _manager;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(chuyenLoProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        // AppHeader(title: "Chuyển lỗ"),
        AppContainerBorder(
          child: AppBar(
            leading: [
              OutlineButton(
                child: Text("Tính toán số liệu"),
                onPressed: () {
                  ref.read(chuyenLoProvider.notifier).get();
                },
              ),
            ],
          ),
        ),
      ],
      child: state.when(
        data: (val) {
          return AppTable(
            onRowDoubleTap: (event) {
              if (event.cell.column.field == "NamBC") {
                showAppDialog(
                  context,
                  child: ChuyenLoCTScreen(year: int.parse(event.cell.value), chuyenLoId: event.row.cells['stt']?.value),
                );
              }
            },
            onLoaded: (e) {
              _manager = ChuyenLoTableManager(e.stateManager);
              _manager.loadView(val);
            },
            columnGroups: [
              TrinaColumnGroup(
                title: 'Số lãi lỗ',
                fields: ['Q1', 'Q2', 'Q3', 'Q4'],
                backgroundColor: Colors.gray.shade100,
              ),
            ],
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                readOnly: true,
                width: 35,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(
                title: ['Năm báo cáo', 'NamBC'],
                width: 120,
                renderer: (re) => AppTableCell.textRed(re.cell.value).withAlign(Alignment.center),
                columnAlign: ColumnAlign.center,
              ),
              AppTableColumn(
                title: ['Lãi/lỗ', 'LoiNhuan'],
                width: 100,
                columnType: ColumnType.num,
                showFooter: true,
                renderer: (re) => AppTableCell.textBlue(
                  NumHelper.numFormat(re.cell.value, lamTron: true),
                ).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Số lỗ lũy kế', 'SoLuyKe'],
                width: 100,
                columnType: ColumnType.num,
                renderer: (re) => AppTableCell.textBlue(
                  NumHelper.numFormat(re.cell.value, lamTron: true),
                ).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Tiền nộp thuế', 'NopThue'],
                width: 120,
                columnType: ColumnType.num,
                showFooter: true,
                renderer: (re) => AppTableCell.textBlue(
                  NumHelper.numFormat(re.cell.value, lamTron: true),
                ).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Quý 1', 'Q1'],
                width: 100,
                columnType: ColumnType.num,
                renderer: (re) => AppTableCell.textRed(
                  NumHelper.numFormat(re.cell.value, lamTron: true),
                ).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Quý 2', 'Q2'],
                width: 100,
                columnType: ColumnType.num,
                renderer: (re) => AppTableCell.textRed(
                  NumHelper.numFormat(re.cell.value, lamTron: true),
                ).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Quý 3', 'Q3'],
                width: 100,
                columnType: ColumnType.num,
                renderer: (re) => AppTableCell.textRed(
                  NumHelper.numFormat(re.cell.value, lamTron: true),
                ).withAlign(Alignment.centerRight),
              ),
              AppTableColumn(
                title: ['Quý 4', 'Q4'],
                width: 100,
                columnType: ColumnType.num,
                renderer: (re) => AppTableCell.textRed(
                  NumHelper.numFormat(re.cell.value, lamTron: true),
                ).withAlign(Alignment.centerRight),
              ),
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
