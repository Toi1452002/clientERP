import 'dart:io';

import 'package:erp_client_1/features/system/users/presentation/dialog/user_changed_password.dart';
import 'package:erp_client_1/features/system/users/presentation/dialog/user_form.dart';
import 'package:erp_client_1/features/system/users/presentation/notifier/user_view_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:trina_grid/trina_grid.dart';

import '../../../../../../core/widgets/widget.dart';
import '../state/user_table_state.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserTable extends ConsumerStatefulWidget {
  const UserTable({super.key});

  @override
  UserTableState createState() => UserTableState();
}

class UserTableState extends ConsumerState<UserTable> {
  late UserTableManager _tableState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userViewProvider);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: state.when(
        skipLoadingOnRefresh: false,
        data: (users) {
          return AppTable(
            onRowDoubleTap: (event) {
              if (event.cell.column.field == 'Username') {
                final id = event.row.cells['delete']?.value;
                showAppDialog(context, child: UserForm(id: id));
                // context.goNamed(userEdit, pathParameters: {'id': id.toString()});
              }
            },
            onLoaded: (e) {
              _tableState = UserTableManager(e.stateManager);
              _tableState.loadView(users);
            },
            columns: [
              AppTableColumn(
                title: ['', 'stt'],
                width: 35,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(
                title: ['', 'delete'],
                width: 25,
                renderer: (re) => AppTableCell.delete(() {
                  showQuestion(
                    context,
                    onPressed: () async {
                      _tableState.setCurrent(re);
                      final result = await ref.read(userViewProvider.notifier).delete(re.cell.value!);
                      if (result) {
                        _tableState.delete(re);
                      }
                    },
                  );
                }),
              ),
              AppTableColumn(
                title: ['Username', 'Username'],
                width: 150,
                renderer: (re) => AppTableCell.textRed(re.cell.value),
              ),
              AppTableColumn(title: ['Họ và tên', 'HoTen'], width: 200),
              AppTableColumn(title: ['Email', 'Email'], width: 200),
              AppTableColumn(title: ['Điện thoại', 'DienThoai'], width: 200),
              AppTableColumn(
                title: ['', 'ChangedPassword'],
                width: 150,
                renderer: (re) {
                  return LinkButton(
                    child: Text('Change Password', style: TextStyle(color: Colors.blue.shade800)),
                    onPressed: () {
                      _tableState.setCurrent(re);
                      final id = re.row.cells['delete']?.value;
                      final username = re.row.cells['Username']?.value;
                      showAppDialog(
                        context,
                        child: UserChangePassword(id: id, username: username),
                      );
                      // context.goNamed(
                      //   userChangePassword,
                      //   pathParameters: {"id": id.toString()},
                      //   queryParameters: {'username': username},
                      // );
                    },
                  );
                },
              ),
            ],
          );
        },
        error: (e, s) => Center(
          child: Text(e.toString(), style: TextStyle(color: Colors.gray)),
        ),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
