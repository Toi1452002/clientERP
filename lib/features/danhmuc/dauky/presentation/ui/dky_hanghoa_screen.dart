import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/notifier/dky_update_notifier.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/ui/state/dky_hanghoa_table_manager.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/dky_hanghoa_view_notifier.dart';

class DKyHangHoaScreen extends ConsumerStatefulWidget {
  const DKyHangHoaScreen({super.key});

  @override
  ConsumerState createState() => _DKyHangHoaScreenState();
}

class _DKyHangHoaScreenState extends ConsumerState<DKyHangHoaScreen> {
  late DKyHangHoaTableManager _manager;
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
  }

  void refresh() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(isInit){
        ref.listenManual(dkyHangHoaViewProvider, (_, next) {
          next.whenOrNull(
            data: (val) {
              // _manager.closeLoading();
              _manager.loadView(val);
            },
            loading: () {
              // _manager.showLoading();
            },
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dkyHangHoaViewProvider);
    final stateUpdate = ref.watch(dkyUpdateProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        // AppHeader(
        //   title: "Danh sách tồn đầu kỳ",
          // trailing: [
          //   AppReloadButton(
          //     onPressed: () {
          //       ref.refresh(dkyHangHoaViewProvider);
          //       refresh();
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
          return LoadingOverlay(
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
                            ref.read(dkyUpdateProvider.notifier).updateDKyHangHoa(_manager.toList());

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
                  _manager = DKyHangHoaTableManager(e.stateManager);
                  _manager.loadView(val);
                  isInit = true;
                },
                columns: [
                  AppTableColumn(
                    title: ['#', 'stt'],
                    width: 35,
                    readOnly: true,
                    showFilter: false,
                    renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                  ),
                  AppTableColumn(title: ['Ngày', 'Ngay'], width: 85, columnType: ColumnType.text, isEdit: true),
                  AppTableColumn(
                    title: ['Mã hàng', 'MaHH'],
                    width: 100,
                    readOnly: true
                  ),
                  AppTableColumn(
                    title: ['Tên hàng', 'TenHH'],
                    width: 300,
                    readOnly: true
                  ),
                  AppTableColumn(
                    title: ['Số lượng', 'SoTon'],
                    width: 80,
                    isEdit: true,
                    columnAlign: ColumnAlign.right,
                    columnType: ColumnType.num,
                  ),
                  AppTableColumn(
                    title: ['Giá vốn', 'GiaVon'],
                    width: 100,
                    isEdit: true,
                    columnType: ColumnType.num,
                    showFooter: true,
                    columnAlign: ColumnAlign.right,
                  ),
                  AppTableColumn(title: ["","HangHoaId"],hide: true)
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
