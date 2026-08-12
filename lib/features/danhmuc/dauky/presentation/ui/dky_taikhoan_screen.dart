import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/notifier/dky_taikhoan_view_notifier.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/notifier/dky_update_notifier.dart';
import 'package:erp_client_1/features/danhmuc/dauky/presentation/ui/state/dky_taikhoan_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../core/widgets/widget.dart';

class DKyTaiKhoanScreen extends ConsumerStatefulWidget {
  const DKyTaiKhoanScreen({super.key});

  @override
  ConsumerState createState() => _DKyTaiKhoanScreenState();
}

class _DKyTaiKhoanScreenState extends ConsumerState<DKyTaiKhoanScreen> {
  late DKyTaiKhoanTableManager _manager;
  int selectMonth = DateTime.now().month;
  final txtNam = TextEditingController(text: DateTime.now().year.toString());


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

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dkyTaiKhoanViewProvider);
    final stateUD = ref.watch(dkyUpdateProvider);
    return Scaffold(
      backgroundColor: AppColor.background,
      headers: [
        AppHeader(title: "Danh sách đầu kỳ tài khoản",trailing: [
          AppReloadButton(onPressed: (){
            ref.refresh(dkyTaiKhoanViewProvider);
            _manager.showLoading();
            ref.listenManual(dkyTaiKhoanViewProvider, (_,next){
              next.whenData((data){

                _manager.loadView(data);
                _manager.closeLoading();
              });
            });
          },),
          Gap(10)
        ],)
      ],
      child: Padding(
        padding: EdgeInsets.all(10),
        child: state.when(
          data: (val) {
            return LoadingOverlay(
              isLoading: stateUD.isLoading,
              child: Scaffold(
                headers: [
                  AppBar(
                    leading: [
                      Text('Tháng'),
                      SizedBox(
                        width: 50,
                        child: AppCombobox(
                          value: selectMonth,
                          enabledClear: false,
                          onChanged: (val) {
                            setState(() {
                              selectMonth = val;
                            });
                          },
                          items: [
                            for (int i = 1; i <= 12; i++) ComboboxItem(value: i, text: [i.toString()]),
                          ],
                        ),
                      ),
                      Gap(5),
                      Text('Năm'),
                      SizedBox(width: 50, child: AppTextField(controller: txtNam,isNumber: true,maxLength: 4,)),

                    ],
                    trailing: [
                      AppSaveButton(
                        text: "Thực hiện lưu đầu kỳ",
                        onPressed: (){
                          ref.read(dkyUpdateProvider.notifier).ghiDKTK(selectMonth, txtNam.text);
                        },
                      )
                    ],
                  )
                ],
                child: AppTable(
                  onLoaded: (e){
                    _manager = DKyTaiKhoanTableManager(e.stateManager);
                    _manager.loadView(val);
                  },
                  onChange: (re){
                    final field = re.column.field;
                    final maTK = re.row.cells['MaTK']?.value;
                    if(field == "DKNo"){
                      ref.read(dkyUpdateProvider.notifier).updateCKNo(re.cell.value, maTK);
                    }else if(field=="DKCo"){
                      ref.read(dkyUpdateProvider.notifier).updateCKCo(re.cell.value, maTK);
                    }
                  },
                  columns: [
                    AppTableColumn(
                      title: ['#', 'stt'],
                      width: 35,
                      readOnly: true,
                      showFilter: true,
                      renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                    ),
                    AppTableColumn(title: ['Mã TK', 'MaTK'], width: 80, readOnly: true),
                    AppTableColumn(title: ['Mô tả tài khoản', 'TenTK'], width: 290, readOnly: true),
                    AppTableColumn(title: ['TC', 'TinhChat'], width: 50, columnAlign: ColumnAlign.center, readOnly: true),
                    AppTableColumn(
                      title: ['Đầu kỳ nợ', 'DKNo'],
                      width: 100,
                      isEdit: true,
                      columnType: ColumnType.num,
                      columnAlign: ColumnAlign.right,
                      showFooter: true,
                    ),
                    AppTableColumn(
                      title: ['Đầu kỳ có', 'DKCo'],
                      width: 100,
                      isEdit: true,
                      columnType: ColumnType.num,
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
      ),
    );
  }
}
