import 'package:erp_client_1/core/widgets/app_alert.dart';
import 'package:erp_client_1/core/widgets/app_table/app_table.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/data/model/sothue_model.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/notifier/sothue_notifier.dart';
import 'package:erp_client_1/features/soketoan/baocaothue/presentation/ui/state/sothue_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/utils/num_helper.dart';

class TableGTGT extends ConsumerStatefulWidget {
  const TableGTGT({super.key});

  @override
  ConsumerState createState() => _TableGTGTState();
}

class _TableGTGTState extends ConsumerState<TableGTGT> {
  late SoThueTableManager _manager;
  bool isInit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.listenManual(stGTGTProvider, (_,next){
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
    });


  }
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stGTGTProvider);
    return Scaffold(
      child: state.when(
        skipLoadingOnReload: true,
        data: (val) {
          return AppTable(
            onLoaded: (e) {
              _manager = SoThueTableManager(e.stateManager);
              _manager.loadView(val);
              isInit = true;
            },
            onChange: (re) async{
              try{
                final field =re.column.field;
                final id = re.row.cells['Tinh']?.value;
                if(["SoBaoCao","SoDaNop"].contains(field)){
                  await ref.read(stGTGTProvider.notifier).updateGTGT(_manager.toModelGTGT(re), id);
                }
              }catch(e){
                showInfo(context, e.toString());
              }
            },
            columns: [
              AppTableColumn(
                title: ['#', 'stt'],
                width: 40,
                readOnly: true,
                renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
              ),
              AppTableColumn(title: ['Năm', 'Nam'], width: 80, columnAlign: ColumnAlign.center, readOnly: true),
              AppTableColumn(
                title: ['Số kỳ trước', 'SoKyTruoc'],
                width: 100,
                columnType: ColumnType.num,
                renderer: (re) =>
                    AppTableCell.textBlue(NumHelper.numFormat(re.cell.value)).withAlign(Alignment.centerRight),
                readOnly: true,
              ),
              AppTableColumn(
                title: ['Số báo cáo', 'SoBaoCao'],
                showFooter: true,
                width: 100,
                columnType: ColumnType.num,
                columnAlign: ColumnAlign.right,

                isEdit: true,
              ),
              // AppTableColumn( title: ['Số kiểm tra', 'SoKiemTra'],
              //   showFooter: true,
              //   width: 100,
              //   columnType: ColumnType.num,
              //   columnAlign: ColumnAlign.right,
              //
              //   isEdit: true,),
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
              AppTableColumn(
                title: ['', 'Tinh'],
                width: 50,
                renderer: (re) => LinkButton(
                  child: Text('Tính', style: TextStyle(color: Colors.blue.shade800)),
                  onPressed: () async{
                    _manager.setCurrent(re);
                    try{
                      final nam = re.row.cells['Nam']?.value;
                      final id = re.cell.value;
                      await ref.read(stGTGTProvider.notifier).tinhGTGT(int.parse(nam), id);

                    }catch(e){
                      showInfo(context, e.toString());
                    }
                  },
                ),
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
