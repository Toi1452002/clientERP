import 'package:erp_client_1/core/constain/app_color.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_datefield.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/congno/presentation/notifier/tonghopcongno_notifier.dart';
import 'package:erp_client_1/features/congno/presentation/ui/state/tonghopcongno_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:trina_grid/trina_grid.dart';

class TongHopCongNoScreen extends ConsumerStatefulWidget {
  const TongHopCongNoScreen({super.key});

  @override
  ConsumerState createState() => _TongHopCongNoScreenState();
}

class _TongHopCongNoScreenState extends ConsumerState<TongHopCongNoScreen> {
  late TongHopCongNoTableManager _manager;
  DateTime? date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tongHopCongNoProvider);
    return Scaffold(
      backgroundColor: AppColor.background,
      footers: [
        AppFooter()
      ],
      headers: [
        AppHeader(title: "Tổng hợp công nợ"),
        AppBar(
          leading: [
            SizedBox(width: 100,child: AppDateField(onChanged: (val){
              date = val;
            },value: date,)),
            OutlineButton(child: Text('Thực hiện'),onPressed: (){
              if(date!=null){
                ref.read(tongHopCongNoProvider.notifier).get(date!);
              }
            },)
          ],
        ),
        Divider(color: AppColor.border300,)
      ],
      child: state.when(
        data: (val) {
          return Scaffold(
            headers: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.border)
                ),
                child: AppBar(
                  leading: [
                    AppPrintButton()
                  ],
                ),
              )
            ],
            child: AppTable(onLoaded: (e){
              _manager = TongHopCongNoTableManager(e.stateManager);
              _manager.loadView(val);
            },
              columnGroups: [
                // TrinaColumnGroup(title: 'Khách hàng', backgroundColor: Colors.blue.shade300, fields: ['MaKhach', 'TenKH']),
                TrinaColumnGroup(
                  title: 'Số dư cuối kỳ',
                  backgroundColor: Colors.gray.shade100,
                  fields: ['PhaiThu', 'PhaiTra'],
                ),
              ],
              columns: [
                AppTableColumn(
                  title: ['', 'stt'],
                  width: 40,
                  renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
                  readOnly: true,
                ),
                AppTableColumn(
                  title: ['Mã KH', 'MaKH'],
                  width: 100,
                  renderer: (re) => AppTableCell.textRed(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Tên khách hàng', 'TenKH'],
                  width: 250,
                  renderer: (re) => AppTableCell.textBlue(re.cell.value),
                ),
                AppTableColumn(
                  title: ['Phải thu', 'PhaiThu'],
                  width: 120,
                  columnType: ColumnType.num,
                  columnAlign: ColumnAlign.right,
                  showFooter: true,
                ),
                AppTableColumn(
                  title: ['Phải trả', 'PhaiTra'],
                  width: 120,
                  columnType: ColumnType.num,
                  columnAlign: ColumnAlign.right,
                  showFooter: true,
                ),
              ],),
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
