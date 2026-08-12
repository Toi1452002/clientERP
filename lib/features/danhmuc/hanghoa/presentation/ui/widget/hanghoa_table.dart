import 'dart:math';

import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/dialog/hanghoa_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/hanghoa/presentation/ui/state/hanghoa_table_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/widgets/widget.dart';
import '../../notifier/hanghoa_view_notifierr.dart';

class HangHoaTable extends ConsumerStatefulWidget {
  const HangHoaTable({super.key});

  @override
  ConsumerState createState() => _HangHoaTableState();
}

class _HangHoaTableState extends ConsumerState<HangHoaTable> {
  late HangHoaTableManager _tableState;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(hangHoaViewProvider);

    return state.when(
      skipLoadingOnRefresh: false,
      data: (value) {
        return Scaffold(
          headers: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: AppColor.border)),
              child: AppBar(
                leading: [
                  AppPrintButton()
                ],
              ),
            )
          ],
          child: AppTable(
            onLoaded: (e){
              _tableState = HangHoaTableManager(e.stateManager);
              _tableState.loadView(value);
              _tableState.showFilter();
            },
            onRowDoubleTap: (event){
              if(_tableState.getColumnField(event.cell)=="MaHH"){
                final id = event.row.cells['delete']?.value;
                showAppDialog(context, child: HangHoaFormDialog(id: id,));
                // context.goNamed(hangHoaEdit,pathParameters: {'id': id.toString()});
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
                renderer: (re) => AppTableCell.delete(() {
                  _tableState.setCurrent(re);
                  showQuestion(context,onPressed: () async{
                    try{
                      final id = re.cell.value;
                      await ref.read(hangHoaViewProvider.notifier).deleteHangHoa(id);
                      _tableState.delete(re);
                    }catch(e){
                      if(context.mounted) showInfo(context, e.toString());
                    }
                  });
                }),
              ),

              AppTableColumn(title: ['Mã', 'MaHH'], width: 135, renderer: (re) => AppTableCell.textRed(re.cell.value)),
              AppTableColumn(title: ['Tên vật tư-hàng hóa', 'TenHH'], width: 300),
              AppTableColumn(title: ['Đơn vị tính', 'DVT'], width: 110, columnAlign: ColumnAlign.center),
              AppTableColumn(
                title: ['Giá mua', 'GiaMua'],
                width: 140,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,
              ),
              AppTableColumn(
                title: ['Giá bán', 'GiaBan'],
                width: 140,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,
              ),
              AppTableColumn(title: ['Loại hàng', 'LoaiHang'], width: 100, columnAlign: ColumnAlign.center),
              AppTableColumn(title: ['Nhóm hàng', 'NhomHang'], width: 110, columnAlign: ColumnAlign.center),
              AppTableColumn(title: ['Nhà cung', 'MaNC'], width: 95, columnAlign: ColumnAlign.center),
            ],
          ),
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: CircularProgressIndicator(size: 50,)),
    );
  }
}
