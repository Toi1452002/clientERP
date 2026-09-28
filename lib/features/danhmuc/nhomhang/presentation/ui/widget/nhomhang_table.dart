import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/notifier/nhomhang_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/notifier/nhomhang_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhomhang/presentation/ui/state/nhomhang_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/app_alert.dart';
import '../../../../../../core/widgets/app_table/app_table.dart';

class NhomHangTable extends ConsumerStatefulWidget {
  const NhomHangTable({super.key});

  @override
  ConsumerState createState() => _NhomHangTableState();
}

class _NhomHangTableState extends ConsumerState<NhomHangTable> {
  late NhomHangTableManager _tableState;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(nhomHangEditProvider, (_, next) {
      if (isInit) {
        next.whenOrNull(
          data: (val) {
            if (val != null) {
              ref.read(nhomhangProvider.notifier).changedRow(val);
            }
            _tableState.closeLoading();
          },
          loading: () {
            _tableState.showLoading();
          },
          error: (e, s) {
            _tableState.closeLoading();
            // showInfo(context, e.toString());
          },
        );
      }
    });

    ref.listenManual(nhomhangProvider, (_, next) {
      if (isInit) {
        next.whenOrNull(
          data: (val) {
            _tableState.loadView(val);
            _tableState.closeLoading();
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nhomhangProvider);
    return state.when(
      skipLoadingOnReload: isInit,
      data: (value) {
        return AppTable(
          onLoaded: (e) {
            _tableState = NhomHangTableManager(e.stateManager);
            _tableState.loadView(value);
            isInit = true;
          },
          onChange: (e) async {
            if (_tableState.getColumnField(e.cell) == "NhomHang") {
              final id = e.row.cells['delete']?.value;
              final nhomHang = e.cell.value;
              ref.read(nhomHangEditProvider.notifier).updateNhomHang(nhomHang, id);
            }
          },

          columns: [
            AppTableColumn(
              title: ['', 'stt'],
              width: 35,
              readOnly: true,
              showFilter: false,
              renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
            ),
            AppTableColumn(
              title: ['', 'delete'],
              width: 25,
              padding: 0,
              showFilter: false,
              renderer: (re) => AppTableCell.delete(() async {
                _tableState.setCurrent(re);
                _tableState.showLoading();
                showQuestion(context,onPressed: () async {
                  try {

                    final id = re.cell.value;
                    await ref.read(nhomhangProvider.notifier).delete(id);

                  } catch (e) {
                    if (context.mounted) showInfo(context, e.toString());

                  }
                });
                _tableState.closeLoading();
              }),
            ),
            AppTableColumn(title: ['Nhóm hàng', 'NhomHang'], isEdit: true, width: 200),
          ],
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
