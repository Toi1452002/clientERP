import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(roleViewProvider);
    return state.when(
      data: (val) {
        return AppTable(
          onLoaded: (e){
            _tableState = RoleTableManager(e.stateManager);
            _tableState.loadView(val);
          },
          onChange: (re) async{
            if(re.column.field == "RoleName"){
              try{
                final id = re.row.cells['delete']?.value;
                final roleName = re.cell.value;
                await ref.read(roleViewProvider.notifier).updateRoleName(id, roleName);
              }catch(e){
                if(context.mounted) showInfo(context, e.toString());
              }
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
                try {
                  final id = re.cell.value;
                  await ref.read(roleViewProvider.notifier).delete(id);
                  _tableState.delete(re);
                } catch (e) {
                  if (context.mounted) showInfo(context, e.toString());
                }
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
