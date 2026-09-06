import 'package:erp_client_1/features/system/menu_permission/data/repository/menu_permission_repository.dart';
import 'package:erp_client_1/features/system/menu_permission/presentation/notifier/menu_permission_notifier.dart';
import 'package:erp_client_1/features/system/menu_permission/presentation/ui/state/menu_permission_table_manager.dart';
import 'package:erp_client_1/features/system/roles/presentation/dialog/role_dialog.dart';
import 'package:erp_client_1/features/system/roles/presentation/notifier/role_view_notifier.dart';
import 'package:erp_client_1/features/system/roles/presentation/ui/widget/role_combobox.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/widgets/widget.dart';

class MenuPermissionScreen extends ConsumerStatefulWidget {
  const MenuPermissionScreen({super.key});

  @override
  ConsumerState createState() => _MenuPermissionScreenState();
}

class _MenuPermissionScreenState extends ConsumerState<MenuPermissionScreen> {
  late MenuPermissionTableManager _stateManager;
  int? selectRole;
  bool enableSave = false;


  void save() async{
    if(enableSave){
      try {
        if (selectRole != null) {
          final result = await ref
              .read(menuPermissionProvider.notifier)
              .updatePermission(selectRole!, _stateManager.listKChoPhep());
          if (result) {
            if (context.mounted) showInfo(context, "Lưu thành công");
            setState(() {
              enableSave = false;
            });
          }
        }
      } catch (e) {
        if (context.mounted) showInfo(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(menuPermissionProvider);
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.keyS, control: true): () {
           save();
        },
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        footers: [
          AppFooter()
        ],
        headers: [
          AppHeader(title: "Phân quyền người dùng",trailing: [ AppReloadButton(
            onPressed: (){
              ref.refresh(roleViewProvider);
              // ref.invalidate(menuPermissionProvider);
            },
          ),
            Gap(10),],),
          AppBar(
            leading: [
              Text('Vai trò'),
              Gap(5),
              SizedBox(
                width: 200,
                child: RoleCombobox(
                  selectId: selectRole,
                  onChanged: (val) {
                    ref.read(menuPermissionProvider.notifier).loadMenu(val);
                    setState(() {
                      selectRole = val;
                    });
                  },
                ),
              ),
              AppAddButton(
                onPressed: (){
                  showAppDialog(context, child: RoleDialog());
                },
              ),
              Gap(5),
            ],
          ),
          Divider(color: AppColor.border300,)
        ],
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: state.when(
            skipLoadingOnRefresh: false,
            data: (val) {
              if (val.isEmpty) return Center(child: Text('Chọn vai trò',style: TextStyle(color: Colors.gray),));
              return Scaffold(
                headers: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.border)
                    ),
                    child: AppBar(
                      trailing: [
                        AppSaveButton(
                          enabled: enableSave,
                          onPressed: ()  async {
                            save();
                          },
                        ),
                      ],
                    ),
                  )
                ],
                child: AppTable(
                  onLoaded: (e) {
                    _stateManager = MenuPermissionTableManager(e.stateManager);
                    _stateManager.loadView(val);
                  },
                  rowColorCallback: (re) {
                    if (re.row.cells['Level']?.value == 0) {
                      return Colors.yellow.shade100;
                    }
                    return Colors.transparent;
                  },
                  columns: [
                    AppTableColumn(title: ['', 'Level'], columnType: ColumnType.num, hide: true),
                    AppTableColumn(
                      title: ['', 'stt'],
                      width: 35,
                      readOnly: true,
                      renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                    ),
                    AppTableColumn(title: ["Mô tả", "TreeName"], width: 400),
                    AppTableColumn(
                      title: ["Cho phép", "Status"],
                      width: 100,
                      columnType: ColumnType.boolean,
                      renderer: (re) {
                        return Align(
                          alignment: Alignment.center,
                          child: Checkbox(
                            state: re.cell.value ? CheckboxState.checked : CheckboxState.unchecked,
                            onChanged: (val) {
                              re.cell.value = val.index == 0;
                              _stateManager.setCurrent(re);
                              re.stateManager.notifyListeners();
                              setState(() {
                                enableSave = true;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
            error: (e, s) => Center(child: Text(e.toString())),
            loading: () => Center(child: CircularProgressIndicator(size: 50)),
          ),
        ),
      ),
    );
  }
}
