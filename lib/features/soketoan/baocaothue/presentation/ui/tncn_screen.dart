import 'package:erp_client_1/features/soketoan/baocaothue/presentation/notifier/tncn_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/state/tncn_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../core/utils/date_helper.dart';
import '../../../../../core/utils/num_helper.dart';
import '../../../../../core/widgets/widget.dart';

class TNCNScreen extends ConsumerStatefulWidget {
  const TNCNScreen({super.key});

  @override
  ConsumerState createState() => _TNCNScreenState();
}

class _TNCNScreenState extends ConsumerState<TNCNScreen> {
  int quy = DateHelper.getQuarterNow();
  final txtNam = TextEditingController(text: (DateTime.now().year-1).toString());
  late TNCNTableManager _manager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(tncnProvider.notifier).get(int.parse(txtNam.text), quy);
    });
  }



  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tncnProvider);
    return Scaffold(
      footers: [AppFooter()],
      headers: [
        // AppHeader(title: "Thuế thu nhập cá nhân"),
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
                ref.read(tncnProvider.notifier).get(int.tryParse(txtNam.text)??DateTime.now().year, quy);
              },)

            ],
          ),
        ),
      ],
      child: state.when(
        data: (val) {
          return AppTable(
            rowColorCallback: (re) {
              if (re.row.cells['PhanCap']?.value == 1) {
                return Colors.cyan.shade100;
              } else {
                return Colors.transparent;
              }
            },
            onLoaded: (e) {
              _manager = TNCNTableManager(e.stateManager);
              _manager.loadView(val);
            },
            columns: [
              AppTableColumn(title: ['', 'PhanCap'], hide: true),
              AppTableColumn(
                title: ['#', 'stt'],
                width: 40,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(
                title: ['STT', 'STT'],
                width: 70,
                renderer: (re) => re.row.cells['PhanCap']?.value == 1
                    ? AppTableCell.textRed(re.cell.value)
                    : AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(
                title: ['Chỉ tiêu', 'ChiTieu'],
                width: 800,
                renderer: (re) => re.row.cells['PhanCap']?.value == 1
                    ? AppTableCell.textRed(re.cell.value)
                    : AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(
                title: ['Mã CT', 'MaSo'],
                width: 80,
                renderer: (re) => re.row.cells['PhanCap']?.value == 1
                    ? AppTableCell.textRed(re.cell.value)
                    : AppTableCell.textBlue(re.cell.value),
              ),
              AppTableColumn(
                title: ['ĐVT', 'DVT'],
                width: 80,
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
                  NumHelper.numFormat(re.cell.value, lamTron: true),
                ).withAlign(Alignment.centerRight)
                    : AppTableCell.textBlue(
                  NumHelper.numFormat(re.cell.value, lamTron: true),
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
