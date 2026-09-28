import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/dialog/khach_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/notifier/khach_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/khach/presentation/ui/state/khach_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/app_alert.dart';

class KhachTable extends ConsumerStatefulWidget {
  const KhachTable({super.key});

  @override
  ConsumerState createState() => _KhachTableState();
}

class _KhachTableState extends ConsumerState<KhachTable> {
  late KhachTableManager _tableManager;
  bool isInit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(khachViewProvider, (_, next) {
      if (isInit) {
        next.whenOrNull(
            data: (val) {
              _tableManager.loadView(val);
              _tableManager.closeLoading();
              _tableManager.clearFilter();
            },
            loading: () {
              _tableManager.showLoading();
            },
            error: (e,s){
              isInit = false;
              _tableManager.closeLoading();

              showInfo(context, e.toString());
            }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(khachViewProvider);
    return state.when(
      skipLoadingOnReload: isInit,
      skipLoadingOnRefresh: isInit,
      data: (val) {
        return Scaffold(
          child: AppTable(
            onLoaded: (e){
              _tableManager = KhachTableManager(e.stateManager);
              _tableManager.loadView(val);
              _tableManager.showFilter();
              isInit = true;
            },
            onRowDoubleTap: (re){
              if(re.cell.column.field == "MaKH"){
                final id = re.row.cells['delete']?.value;
                showAppDialog(context, child: KhachFormDialog(id: id,));
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
                renderer: (re) => AppTableCell.delete(() {
                  _tableManager.setCurrent(re);
                  _tableManager.showLoading();
                  showQuestion(
                    context,
                    onPressed: () async {
                      try {
                        await ref.read(khachViewProvider.notifier).delete(re.cell.value);
                      } catch (e) {
                        if (context.mounted) showError(context, e.toString());
                      }
                    },
                  );
                  _tableManager.closeLoading();
                }),
              ),

              AppTableColumn(title: ['Mã KH', 'MaKH'], width: 120, renderer: (re) => AppTableCell.textRed(re.cell.value)),
              AppTableColumn(title: ['Tên khách hàng', 'TenKH'], width: 300),
              AppTableColumn(title: ['Địa chỉ', 'DiaChi'], width: 250),
              AppTableColumn(title: ['MST', 'MST'], width: 120),
              AppTableColumn(title: ['Di động', 'DiDong'], width: 120),
              AppTableColumn(title: ['Loại', 'LoaiKH'], width: 80, columnAlign: ColumnAlign.center),
            ],
          ),
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: CircularProgressIndicator(size: 50)),
    );
  }
}
