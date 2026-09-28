import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/dialog/nhanvien_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/notifier/nhanvien_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/nhanvien/presentation/ui/state/nhanvien_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NhanVienTable extends ConsumerStatefulWidget {
  const NhanVienTable({super.key});

  @override
  ConsumerState createState() => _NhanVienTableState();
}

class _NhanVienTableState extends ConsumerState<NhanVienTable> {
  late NhanVienTableManager _manager;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(nhanVienViewProvider, (_, next){
      if(isInit){
        next.whenOrNull(
          data: (val){
            _manager.loadView(val);
            _manager.closeLoading();
          },
          error: (e,s){
            showInfo(context, e.toString());
            isInit = false;
            _manager.closeLoading();
          },

          loading: (){
            _manager.showLoading();
        }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nhanVienViewProvider);
    return state.when(
      skipLoadingOnRefresh: isInit,
      data: (val) {
        return AppTable(
          onLoaded: (e){
            _manager = NhanVienTableManager(e.stateManager);
            _manager.loadView(val);
            isInit = true;
          },
          onRowDoubleTap: (re){
            if(re.cell.column.field == "MaNV"){
              final id = re.row.cells['delete']?.value;
              showAppDialog(context, child: NhanVienFormDialog(id: id,));
            }
          },
          columns: [
            AppTableColumn(
              title: ['#', 'stt'],
              width: 35,
              readOnly: true,
              renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              showFilter: false,
            ),
            AppTableColumn(
              title: ['', 'delete'],
              width: 25,
              renderer: (re) => AppTableCell.delete(() async {
                final id = re.cell.value;
                _manager.setCurrent(re);
                showQuestion(context,onPressed: () async{
                  _manager.showLoading();
                  try{
                    await ref.read(nhanVienViewProvider.notifier).delete(id);
                  }catch(e){
                    if(context.mounted) showInfo(context, e.toString());
                  }
                  _manager.closeLoading();
                });
                // _controller.removeRow(re);
                // md.removeRow(ref, re.cell.value, re);
              }),
              showFilter: false,
            ),
            AppTableColumn(title: ['Mã NV', 'MaNV'], width: 100, renderer: (re) => AppTableCell.textRed(re.cell.value)),
            AppTableColumn(title: ['Họ tên', 'TenNV'], width: 200),
            AppTableColumn(title: ['Giới tính', 'GioiTinh'], width: 80),
            AppTableColumn(
              title: ['Ngày sinh', 'NgaySinh'],
              width: 110,
              columnType: ColumnType.date,
              // renderer: (re) => AppTableCell.textBlue(Helper.dMy(re.cell.value)),
            ),
            AppTableColumn(title: ['Địa chỉ', 'DiaChi'], width: 200),
            AppTableColumn(title: ['Trình độ', 'TrinhDo'], width: 130),
            AppTableColumn(title: ['Chuyên môn', 'ChuyenMon'], width: 130),
          ],
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => Center(child: CircularProgressIndicator(size: 50)),
    );
  }
}
