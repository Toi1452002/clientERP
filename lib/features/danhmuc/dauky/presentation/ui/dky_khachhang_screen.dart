import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_loading_overlay.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/notifier/dky_update_notifier.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/notifier/dky_khachhang_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/ui/state/dky_khachhang_table_manager.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DKyKhachHangScreen extends ConsumerStatefulWidget {
  const DKyKhachHangScreen({super.key});

  @override
  ConsumerState createState() => _DKyKhachHangScreenState();
}

class _DKyKhachHangScreenState extends ConsumerState<DKyKhachHangScreen> {
  late DKyKhachHangTableManager _manager;
  bool isInit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.listenManual(dkyUpdateProvider, (_, next) {
      next.whenOrNull(
        data: (val) {
          showInfo(context, "Cập nhật thành công");
        },
        error: (e, s) {
          showInfo(context, e.toString());
        },
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(isInit){
        ref.listenManual(dkyKhachHangViewProvider, (_, next) {
          next.whenOrNull(
            data: (val) {
              _manager.closeLoading();
              _manager.loadView(val);
            },
            loading: () {
              _manager.showLoading();
            },
          );
        });
      }

    });
  }

  // void refresh() {
  //
  // }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dkyKhachHangViewProvider);
    final stateUpdate = ref.watch(dkyUpdateProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        // AppHeader(
        //   title: "Danh sách nợ đầu kỳ",
          // trailing: [
          //   AppReloadButton(
          //     onPressed: () {
          //       ref.refresh(dkyKhachHangViewProvider);
          //       // refresh();
          //     },
          //   ),
          //   Gap(10),
          // ],
        // ),
      ],
      backgroundColor: AppColor.background,
      child: state.when(
        skipLoadingOnRefresh: true,
        data: (val) {
          return AppLoadingOverlay(
            isLoading: stateUpdate.isLoading,
            child: Scaffold(
              headers: [
                AppContainerBorder(
                  child: AppBar(
                    trailing: [
                      AppSaveButton(
                        text:"Thực hiện lưu đầu kỳ",
                        onPressed: () {
                          try{
                            ref.read(dkyUpdateProvider.notifier).updateDKyKhachHang(_manager.toList());

                          }catch(e){
                            showInfo(context, "Có lỗi khi lưu");
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
              child: AppTable(
                onLoaded: (e) {
                  _manager = DKyKhachHangTableManager(e.stateManager);
                  _manager.loadView(val);
                  isInit = true;
                },
                columns: [
                  AppTableColumn(
                    title: ['#', 'stt'],
                    width: 30,
                    readOnly: true,
                    showFilter: false,
                    renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                  ),
                  AppTableColumn(title: ['Ngày', 'Ngay'], width: 85, columnType: ColumnType.text, isEdit: true),
                  AppTableColumn(
                    title: ['Mã KH', 'MaKH'],
                    width: 140,
                    readOnly: true,
                    // renderer: (re) => AppTableCell.textBlue(re.cell.value),
                  ),
                  AppTableColumn(
                    title: ['Tên khách hàng', 'TenKH'],
                    width: 300,
                    readOnly: true,
                    // renderer: (re) => AppTableCell.textBlue(re.cell.value),
                  ),
                  AppTableColumn(
                    title: ['Số đầu kỳ', 'SoDuNo'],
                    width: 100,
                    columnType: ColumnType.num,
                    isEdit: true,
                    showFooter: true,
                    columnAlign: ColumnAlign.right,
                  ),
                ],
              ),
            ),
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
