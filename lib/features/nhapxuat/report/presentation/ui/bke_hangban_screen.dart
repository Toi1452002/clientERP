import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/nhapxuat/report/presentation/notifier/bke_hang_ban_notifier.dart';
import 'package:erp_client_1/features/nhapxuat/report/presentation/ui/state/bke_hang_ban_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constain/app_color.dart';
import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_select_date.dart';

class BKeHangBanScreen extends ConsumerStatefulWidget {
  const BKeHangBanScreen({super.key});

  @override
  ConsumerState createState() => _BKeHangBanScreenState();
}

class _BKeHangBanScreenState extends ConsumerState<BKeHangBanScreen> {
  late BkeHangBanManager _manager;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(bkeHangBanProvider);
    return Scaffold(
      backgroundColor: AppColor.background,
      footers: [AppFooter()],
      headers: [
        // AppHeader(title: 'Bảng kê hàng bán'),
        AppContainerBorder(
          child: AppBar(
            leading: [
              // AppPrintButton(),
              // Gap(150),
              AppSelectDate(
                onSubmit: (t,d,type){
                  ref.read(bkeHangBanProvider.notifier).get(tuNgay: t,denNgay: d);
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
            // headers: [
            //   AppContainerBorder(
            //     child: AppBar(
            //       leading: [
            //
            //       ],
            //     ),
            //   )
            // ],
            child: AppTable(
              onLoaded: (re){
                _manager = BkeHangBanManager(re.stateManager);
                _manager.loadView(val);
              },
              columns: [
                AppTableColumn(
                  title: ['#', 'stt'],
                  width: 35,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                  readOnly: true,
                  showFilter: false,
                ),
                AppTableColumn(
                  title: ['Mã hàng', 'MaHH'],
                  width: 100,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Tên hàng', 'TenHH'],
                  width: 300,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['ĐVT', 'DVT'],
                  width: 80,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
                ),
                AppTableColumn(
                  title: ['Số lg', 'SoLg'],
                  width: 80,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Tiền chưa VAT', 'ThanhTien'],
                  width: 130,
                  showFooter: true,
                  columnType: ColumnType.num,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Thuế', 'ThueSuat'],
                  width: 100,
                  showFooter: true,
                  columnType: ColumnType.num,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Tiền thuế', 'TienThue'],
                  width: 130,
                  showFooter: true,
                  columnType: ColumnType.num,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
                AppTableColumn(
                  title: ['Cộng tiền', 'CongTien'],
                  width: 130,
                  showFooter: true,
                  columnType: ColumnType.num,
                  renderer: (re) =>
                      AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                ),
              ],
            ),
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
