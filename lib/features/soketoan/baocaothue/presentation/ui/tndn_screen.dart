import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_header.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/core/widgets/app_textfield.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/notifier/tndn_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/state/tndn_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/num_helper.dart';

class TNDNScreen extends ConsumerStatefulWidget {
  const TNDNScreen({super.key});

  @override
  ConsumerState createState() => _TNDNScreenState();
}

class _TNDNScreenState extends ConsumerState<TNDNScreen> {
  final txtNam = TextEditingController(text: (DateTime.now().year-1).toString());
  late TNDNTableManager _manager;
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tndnProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        // AppHeader(title: "Thuế thu nhập doanh nghiệp"),
        AppContainerBorder(child: AppBar(
          leading: [
            Text("Năm").medium,
            AppTextField(isNumber: true, controller: txtNam).sized(width: 60),
            OutlineButton(child: Text("Thực hiện"),onPressed: (){
              ref.read(tndnProvider.notifier).get(int.tryParse(txtNam.text)??DateTime.now().year);
            },)
          ],
        ))
      ],
      child: state.when(
        data: (val) {
          return AppTable(
            onLoaded: (e){
              _manager = TNDNTableManager(e.stateManager);
              _manager.loadView(val);
            },
            rowColorCallback: (re) {
              if (re.row.cells['PhanCap']?.value == 1) {
                return Colors.amber.shade100;
              }
              return Colors.transparent;
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                width: 35,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(title: ['','PhanCap'],hide: true),
              AppTableColumn(
                title: ['Chỉ tiêu', 'ChiTieu'],
                width: 700,
                renderer: (re) => AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(
                title: ['Mã', 'MaSo'],
                width: 70,
                columnAlign: ColumnAlign.center,
                renderer: (re) => AppTableCell.textBlue(re.cell.value).withAlign(Alignment.center),
              ),
              AppTableColumn(
                title: ['Số tiền', 'SoNamNay'],
                width: 120,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,
                renderer: (re) => Align(alignment: Alignment.centerRight,child: AppTableCell.textBlue(NumHelper.numFormat(re.cell.value, lamTron: true),)),
              ),
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50,)),
      ),
    );
  }
}
