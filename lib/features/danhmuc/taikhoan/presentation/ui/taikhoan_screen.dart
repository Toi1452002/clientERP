import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_dialog.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/dialog/taikhoan_form_dialog.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/notifier/taikhoan_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/taikhoan/presentation/ui/state/taikhoan_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TaiKhoanScreen extends ConsumerStatefulWidget {
  const TaiKhoanScreen({super.key});

  @override
  ConsumerState createState() => _TaiKhoanScreenState();
}

class _TaiKhoanScreenState extends ConsumerState<TaiKhoanScreen> {
  late TaiKhoanTablemanager _manager;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(taiKhoanViewProvider, (_,next){
      if(isInit){
        next.whenOrNull(
          data: (val){
            _manager.closeLoading();
            _manager.loadView(val);
          },
          loading: (){
            _manager.showLoading();
          },
          error: (e,s){
            _manager.closeLoading();
            isInit = false;
            showInfo(context, e.toString());
          }
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taiKhoanViewProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        AppHeader(
          title: "Danh sách tài khoản kế toán",
          // trailing: [
          //   AppReloadButton(
          //     onPressed: () {
          //       ref.invalidate(taiKhoanViewProvider);
          //     },
          //   ),
          //   Gap(10),
          // ],
        ),
        AppContainerBorder(
          child: AppBar(
            leading: [
              AppNewButton(
                text: "Thêm tài khoản",
                onPressed: () {
                  showAppDialog(context, child: TaiKhoanFormDialog());
                },
              ),
            ],
          ),
        ),
      ],
      child: state.when(
        skipLoadingOnRefresh: isInit,
        skipLoadingOnReload: isInit,
        data: (val) {
          return AppTable(
            onLoaded: (e) {
              e.stateManager.setShowColumnFilter(true);
              _manager = TaiKhoanTablemanager(e.stateManager);
              _manager.loadView(val);
              isInit = true;
            },
            onRowDoubleTap: (re){
              final field = re.cell.column.field;
              final id = re.row.cells['delete']?.value;
              if(field == "MaTK"){
                showAppDialog(context, child: TaiKhoanFormDialog(id: id,));
              }
            },
            rowColorCallback: (re) {
              final maXL = re.row.cells['MaXL']?.value;
              if (maXL == 1) {
                return AppColor.rowParent;
              }
              return Colors.transparent;
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                width: 35,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                readOnly: true,
                showFilter: false,
              ),
              // AppTableColumn(
              //   title: ['', 'delete'],
              //   showFilter: false,
              //   width: 25,
              //   renderer: (re) => AppTableCell.delete(() {
              //     _manager.setCurrent(re);
              //     showQuestion(
              //       context,
              //       onPressed: () async {
              //         try {
              //           await ref.read(taiKhoanViewProvider.notifier).delete(re.cell.value);
              //         } catch (e) {
              //           if (context.mounted) showInfo(context, e.toString());
              //         }
              //       },
              //     );
              //   }),
              // ),
              AppTableColumn(
                title: ['Mã TK', 'MaTK'],
                width: 100,
                renderer: (re) => AppTableCell.textRed(re.cell.value),
              ),
              AppTableColumn(title: ['Mô tả', 'TenTK'], width: 350),
              AppTableColumn(title: ['TC', 'TinhChat'], width: 70, columnAlign: ColumnAlign.center),
              AppTableColumn(title: ['Ghi chú', 'GhiChu'], width: 250),
              AppTableColumn(title: ['Nhóm', 'MaXL'], width: 100, hide: true, columnAlign: ColumnAlign.center),
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
