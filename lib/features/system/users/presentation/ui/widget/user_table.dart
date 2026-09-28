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
  late UserTableManager _manager;
  bool isInit = false;

  @override
  void initState() {
    super.initState();


    ref.listenManual(userViewProvider, (_,next){
      if(isInit){
        next.whenOrNull(
          data: (val){
            _manager.loadView(val);
            _manager.closeLoading();
          },
          loading: (){
            _manager.showLoading();
          },
          error: (e,s){
            showInfo(context, e.toString());
          }
        );
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userViewProvider);
    return Padding(
      padding: const EdgeInsets.all(0),
      child: state.when(
        // skipLoadingOnRefresh: false,
        skipLoadingOnReload: isInit,
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
              _manager = UserTableManager(e.stateManager);
              _manager.loadView(users);
              isInit = true;
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
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
                      _manager.setCurrent(re);
                      await ref.read(userViewProvider.notifier).delete(re.cell.value!);
                      // if (result) {
                      //   _manager.delete(re);
                      // }
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
                    child: Text('Đổi mật khẩu', style: TextStyle(color: Colors.blue.shade800)),
                    onPressed: () {
                      _manager.setCurrent(re);
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
