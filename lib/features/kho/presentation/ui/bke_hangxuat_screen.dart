import 'package:erp_client_1/features/kho/presentation/notifier/bkehangxuat_notifier.dart';
import 'package:erp_client_1/features/kho/presentation/ui/state/bke_nhapxuat_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../core/constain/app_color.dart';
import '../../../../core/utils/num_helper.dart';
import '../../../../core/widgets/widget.dart';

class BKeHangXuatScreen extends ConsumerStatefulWidget {
  const BKeHangXuatScreen({super.key});

  @override
  ConsumerState createState() => _BKeHangXuatScreenState();
}

class _BKeHangXuatScreenState extends ConsumerState<BKeHangXuatScreen> {
  late BKeNhapXuatTableManager _manager;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bKeHangXuatProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      footers: [
        AppFooter()
      ],
      headers: [
        AppHeader(title: "Bảng kê hàng xuất"),
        AppContainerBorder(
          child: AppBar(
            leading: [
              AppTngayDngay(onSubmit: (t,d){
                ref.read(bKeHangXuatProvider.notifier).get(t, d);
              },)
            ],
          ),
        ),
      ],
      child: Padding(
        padding: EdgeInsets.all(0),
        child: state.when(
          data: (val) {
            return Scaffold(
              headers: [
                AppContainerBorder(
                  child: AppBar(
                    leading: [
                      AppPrintButton()
                    ],
                  ),
                )
              ],
              child: AppTable(
                onLoaded: (e){
                  _manager = BKeNhapXuatTableManager(e.stateManager);
                  _manager.loadView(val);
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
                    title: ['Ngày', 'Ngay'],
                    width: 80,
                    columnType: ColumnType.date,
                    columnAlign: ColumnAlign.center,
                    renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                  ),
                  AppTableColumn(
                    title: ['Phiếu', 'Phieu'],
                    width: 80,
                    renderer: (re) => AppTableCell.textRed(re.cell.value),
                  ),
                  AppTableColumn(
                    title: ['Kiểu', 'MaNX'],
                    width: 70,
                    renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                  ),
                  AppTableColumn(
                    title: ['Mã khách', 'MaKH'],
                    width: 100,
                    renderer: (re) => AppTableCell.textRed(re.cell.value),
                  ),
                  AppTableColumn(
                    title: ['Mã hàng', 'MaHH'],
                    width: 120,
                    renderer: (re) => AppTableCell.textRed(re.cell.value),
                  ),
                  AppTableColumn(
                    title: ['Tên hàng', 'TenHH'],
                    width: 200,
                    renderer: (re) => AppTableCell.textBlue(re.cell.value),
                  ),
                  AppTableColumn(
                    title: ['ĐVT', 'DVT'],
                    width: 70,
                    renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                  ),
                  AppTableColumn(
                    title: ['SoLg', 'SoLg'],
                    width: 70,
                    renderer: (re) =>
                        AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                  ),
                  AppTableColumn(
                    title: ['Đơn giá', 'DonGia'],
                    width: 100,
                    renderer: (re) =>
                        AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                  ),
                  AppTableColumn(
                    title: ['Thành tiền', 'ThanhTien'],
                    width: 110,
                    renderer: (re) =>
                        AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                    showFooter: true,
                    columnType: ColumnType.num,
                  ),
                ],
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
