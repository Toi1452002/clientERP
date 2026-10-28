import 'package:erp_client_1/features/nhapxuat/report/presentation/ui/state/bke_hoadon_ban_manager.dart';
import 'package:erp_client_1/features/nhapxuat/xuat/presentation/ui/phieuxuat_screen.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';
import '../notifier/bke_hoadon_ban_notifier.dart';

class BkeHoaDonBanScreen extends ConsumerStatefulWidget {
  const BkeHoaDonBanScreen({super.key});

  @override
  ConsumerState createState() => _BkeHoaDonBanScreenState();
}

class _BkeHoaDonBanScreenState extends ConsumerState<BkeHoaDonBanScreen> {
  late BkeHoaDonBanManager _manager;


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bkeHoaDonBanProvider);
    return Scaffold(
      footers: [AppFooter()],
      backgroundColor: AppColor.background,
      headers: [
        // AppHeader(title: "Bảng kê hóa đơn bán ra"),
        AppContainerBorder(
          child: AppBar(
            leading: [
              AppSelectDate(
                onSubmit: (t,d,type){
                  ref.read(bkeHoaDonBanProvider.notifier).get(tuNgay: t,denNgay: d);
                },
              )
            ],
            trailing: [
              AppPrintButton()

            ],
          ),
        ),
      ],
      child: state.when(
        data: (val){
          return Scaffold(
            child: AppTable(
              onLoaded: (e){
                _manager = BkeHoaDonBanManager(e.stateManager);
                _manager.loadView(val);
              },
              onRowDoubleTap: (re){
                final field = re.cell.column.field;
                if(field == "SoHD"){
                  final phieu = re.row.cells['Phieu']?.value;
                  showAppDialog(context, child: PhieuXuatScreen(phieu: phieu,));
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
                    title: ['Phieu', 'Phieu'],
                    width: 85,
                    renderer: (re) => AppTableCell.textBlue(re.cell.value),
                    hide: true
                ),
                AppTableColumn(
                  title: ['Ký hiệu', 'KyHieu'],
                  width: 85,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(title: ['Số HD', 'SoHD'], width: 80, renderer: (re) => AppTableCell.textRed(re.cell.value)),
                AppTableColumn(
                  title: ['Ngày HD', 'NgayCT'],
                  width: 100,
                  columnType: ColumnType.date,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Tên khách hàng', 'TenKH'],
                  width: 300,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Mã số thuế', 'MST'],
                  width: 120,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Tiền chưa VAT', 'CongTien'],
                  width: 125,
                  columnType: ColumnType.num,
                  showFooter: true,
                  columnAlign: ColumnAlign.right,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Tiền thuế', 'TienThue'],
                  width: 125,
                  columnType: ColumnType.num,
                  showFooter: true,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),

                  columnAlign: ColumnAlign.right,
                ),
                AppTableColumn(
                  title: ['Ghi chú', 'DienGiai'],
                  width: 230,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
              ],
            ),
          );
        },
        error: (e,s)=>Center(child: Text(e.toString()),),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
