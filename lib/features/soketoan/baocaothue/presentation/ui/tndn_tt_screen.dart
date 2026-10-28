import 'package:erp_client_1/core/utils/date_helper.dart';
import 'package:erp_client_1/core/widgets/widget.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/notifier/tndn_tt_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/state/tndn_tt_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utils/num_helper.dart';

class TNDNttScreen extends ConsumerStatefulWidget {
  const TNDNttScreen({super.key});

  @override
  ConsumerState createState() => _TNDNttScreenState();
}

class _TNDNttScreenState extends ConsumerState<TNDNttScreen> {
  int quy = DateHelper.getQuarterNow();
  final txtNam = TextEditingController(text: (DateTime.now().year-1).toString());
  late TNDNttTableManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(tndnttProvider.notifier).get(int.parse(txtNam.text), quy);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tndnttProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        // AppHeader(title: "Thuế tạm tính"),
        AppContainerBorder(
          child: AppBar(
            leading: [
              Text("Quý").medium,
              SizedBox(
                width: 60,
                child: AppCombobox(
                  enabledClear: false,
                  items: [
                    for (int i = 1; i <= 4; i++) ComboboxItem(value: i, text: [i.toString()]),
                  ],
                  value: quy,
                  onChanged: (val) {
                    setState(() {
                      quy = val;
                    });
                  },
                ),
              ),
              Gap(10),
              AppTextField(isNumber: true, controller: txtNam).sized(width: 60),
              OutlineButton(child: Text("Thực hiện"),onPressed: (){
                ref.read(tndnttProvider.notifier).get(int.tryParse(txtNam.text)??DateTime.now().year, quy);
              },)

            ],
          ),
        ),
      ],
      child: state.when(
        data: (val) {
          return AppTable(
            rowColorCallback: (re) {
              if (re.row.cells['PhanCap']?.value == 2) {
                return Colors.amber.shade100;
              } else if (re.row.cells['PhanCap']?.value == 1) {
                return Colors.cyan.shade100;
              } else {
                return Colors.transparent;
              }
            },
            onLoaded: (e) {
              _manager = TNDNttTableManager(e.stateManager);
              _manager.loadView(val);
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                width: 35,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(title: ['', 'PhanCap'], hide: true),
              AppTableColumn(
                title: ['Chỉ tiêu', 'ChiTieu'],
                width: 400,
                renderer: (re) => re.row.cells['PhanCap']?.value == 1
                    ? AppTableCell.textRed(re.cell.value)
                    : AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(
                title: ['Số tiền', 'SoNamNay'],
                width: 130,
                columnType: ColumnType.num,
                renderer: (re) => re.row.cells['PhanCap']?.value == 1
                    ? AppTableCell.textRed(
                        NumHelper.numFormat(re.cell.value, lamTron: true) ?? '',
                      ).withAlign(Alignment.centerRight)
                    : AppTableCell.textBlue(
                        NumHelper.numFormat(re.cell.value, lamTron: true) ?? '',
                      ).withAlign(Alignment.centerRight),
              ),
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
        loading: () => Center(child: CircularProgressIndicator(size: 50)),
      ),
    );
  }
}
