import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/system/roles/presentation/notifier/role_edit_notifier.dart';
import 'package:erp_client_1/features/system/roles/presentation/notifier/role_view_notifier.dart';
import 'package:erp_client_1/features/system/roles/presentation/ui/state/role_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/app_alert.dart';

class RoleTable extends ConsumerStatefulWidget {
  const RoleTable({super.key});

  @override
  ConsumerState createState() => _RoleTableState();
}

class _RoleTableState extends ConsumerState<RoleTable> {
  late RoleTableManager _tableState;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(roleEditProvider, (_, next) {
      if (isInit) {
        next.whenOrNull(
          data: (val) {
            if (val != null) {
              ref.read(roleViewProvider.notifier).changedRow(val);
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

    ref.listenManual(roleViewProvider, (_, next) {
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
    final state = ref.watch(roleViewProvider);
    return state.when(
      skipLoadingOnReload: isInit,
      data: (val) {
        return AppTable(
          onLoaded: (e) {
            _tableState = RoleTableManager(e.stateManager);
            _tableState.loadView(val);
            isInit = true;
          },
          onChange: (re) async {
            if (re.column.field == "RoleName") {
              final id = re.row.cells['delete']?.value;
              final roleName = re.cell.value;
              await ref.read(roleEditProvider.notifier).updateRow(id, roleName);
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
                  final id = re.cell.value;
                  showQuestion(
                    context,
                    onPressed: () async {
                      _tableState.showLoading();
                      try{
                        await ref.read(roleViewProvider.notifier).delete(id);

                      }catch(e){
                        _tableState.closeLoading();
                        if (context.mounted) showInfo(context, e.toString());

                      }
                    },
                  );
                  // _tableState.delete(re);
              }),
            ),
            AppTableColumn(title: ['Vai trò', 'RoleName'], isEdit: true, width: 200),
          ],
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: CircularProgressIndicator(size: 50)),
    );
  }
}
