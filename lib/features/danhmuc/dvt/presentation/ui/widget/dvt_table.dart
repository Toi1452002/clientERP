import 'package:erp_client_1/features/danhmuc/dvt/presentation/notifier/dvt_edit_notifier.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/notifier/dvt_notifier.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/ui/state/dvt_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/app_alert.dart';
import '../../../../../../core/widgets/app_table/app_table.dart';

class DvtTable extends ConsumerStatefulWidget {
  const DvtTable({super.key});

  @override
  ConsumerState createState() => _DvtTableState();
}

class _DvtTableState extends ConsumerState<DvtTable> {
  late DvtTableManager _tableState;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(dvtEditProvider, (_, next) {
      if (isInit) {
        next.whenOrNull(
          data: (val) {
            if (val != null) {
              ref.read(dvtProvider.notifier).changedRow(val);
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

    ref.listenManual(dvtProvider, (_, next) {
      if (isInit) {
        next.whenOrNull(
          data: (val) {
            _tableState.loadView(val);
            _tableState.closeLoading();
          },
          loading: (){
            _tableState.showLoading();
          }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dvtProvider);
    return state.when(
      skipLoadingOnReload: isInit,
      data: (value) {
        return AppTable(
          onLoaded: (e) {
            _tableState = DvtTableManager(e.stateManager);
            _tableState.loadView(value);
            isInit = true;
          },
          onChange: (e) {
            if (_tableState.getColumnField(e.cell) == "DVT") {
              final id = e.row.cells['delete']?.value;
              final dvt = e.cell.value;
              ref.read(dvtEditProvider.notifier).updateDvt(dvt,id);
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
                    await ref.read(dvtProvider.notifier).delete(id);

                  } catch (e) {
                    if (context.mounted) showInfo(context, e.toString());

                  }
                });
                _tableState.closeLoading();
              }),
            ),
            AppTableColumn(title: ['Đơn vị tính', 'DVT'], isEdit: true, width: 200),
          ],
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
