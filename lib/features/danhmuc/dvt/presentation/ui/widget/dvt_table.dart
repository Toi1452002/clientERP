import 'package:erp_client_1/features/danhmuc/dvt/presentation/notifier/dvt_notifier.dart';
import 'package:erp_client_1/features/danhmuc/dvt/presentation/ui/state/dvt_table_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../../../../../core/widgets/app_alert.dart';
import '../../../../../../core/widgets/app_table/app_table.dart';


class DvtTable extends ConsumerStatefulWidget {
  const DvtTable({super.key});

  @override
  ConsumerState createState() => _DvtTableState();
}

class _DvtTableState extends ConsumerState<DvtTable> {
  late  DvtTableManager _tableState;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dvtProvider);
    return state.when(data: (value){
      return AppTable(
        onLoaded: (e){
          _tableState = DvtTableManager(e.stateManager);
          _tableState.loadView(value);
        },
        onChange: (e) async{
          if(_tableState.getColumnField(e.cell)=="DVT"){
            try{
              final id = e.row.cells['delete']?.value;
              final dvt = e.cell.value;
              await ref.read(dvtProvider.notifier).updateDvt(id, dvt);
            }catch(e){
             if(context.mounted) showInfo(context, e.toString());
            }
          }
        },
        // onLoaded: (e) {
        //   _controller.stateManager = e.stateManager;
        //   _controller.loadView();
        // },

        columns: [
          AppTableColumn(
            title: ['', 'stt'],
            width: 35,
            readOnly: true,
            showFilter: false,
            renderer: (re) => AppTableCell.textNum("${re.rowIdx + 1}"),
          ),
          AppTableColumn(
            title: ['', 'delete'],
            width: 25,
            padding: 0,
            showFilter: false,
            renderer: (re) => AppTableCell.delete(() async {
              _tableState.setCurrent(re);
              try{
                final id = re.cell.value;
                await ref.read(dvtProvider.notifier).delete(id);
                _tableState.delete(re);
              }catch(e){
                if(context.mounted) showInfo(context, e.toString());
              }
            }),
          ),
          AppTableColumn(title: ['Đơn vị tính', 'DVT'], isEdit: true, width: 200),
        ],
      );
    }, error: (e,s)=> Center(child: Text(e.toString())), loading: ()=> Center(child: CircularProgressIndicator(),));
  }
}
