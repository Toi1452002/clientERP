import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_button.dart';
import 'package:erp_client_1/core/widgets/app_container_border.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/notifier/phat_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/state/phat_table_manager.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/utils/num_helper.dart';

class TablePhat extends ConsumerStatefulWidget {
  const TablePhat({super.key});

  @override
  ConsumerState createState() => _TablePhatState();
}

class _TablePhatState extends ConsumerState<TablePhat> {
  late PhatTableManager _manager;
  bool isInit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.listenManual(phatProvider, (_,next){
      if(isInit){
        next.whenOrNull(
            data: (val){
              _manager.loadView(val);
              _manager.closeLoading();
            }
            ,loading: (){
          _manager.showLoading();
        }
        );
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(phatProvider);
    return Scaffold(
      headers: [
        AppContainerBorder(child: AppBar(
          leading: [
            AppNewButton(text: "Thêm dòng",onPressed: (){
              ref.read(phatProvider.notifier).addRow();
            },)
          ],
        ))
      ],
      child: state.when(
        data: (val) {
          return AppTable(
            onLoaded: (e){
              _manager = PhatTableManager(e.stateManager);
              _manager.loadView(val);
              isInit = true;
            },
            onChange: (event) async {
              try{
                await ref.read(phatProvider.notifier).updatePhat(_manager.toModel(event));
              }catch(e){
                showInfo(context, e.toString());
              }
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                width: 35,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(title: ['', 'Id'], hide: true),
              AppTableColumn(title: ['Lần', 'Nam'], width: 50, isEdit: true, columnAlign: ColumnAlign.center),
              AppTableColumn(title: ['Ngày nộp', 'Ngay'], width: 90, isEdit: true, columnAlign: ColumnAlign.center),
              AppTableColumn(title: ['Nội dung', 'NoiDung'], width: 250, isEdit: true),
              AppTableColumn(
                title: ['Số kiểm tra', 'SoKiemTra'],
                showFooter: true,
                width: 100,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,

                isEdit: true,
              ),
              AppTableColumn(
                title: ['Số đã nộp', 'SoDaNop'],
                showFooter: true,
                width: 100,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,
                isEdit: true,
              ),
              AppTableColumn(
                title: ['Còn phải nộp', 'ConPhaiNop'],
                width: 110,
                columnType: ColumnType.num,
                readOnly: true,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
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
